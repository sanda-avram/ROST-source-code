/*
   Fast Artificial Neural Network Library (fann)
   Copyright (C) 2003-2016 Steffen Nissen (steffen.fann@gmail.com)

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "floatfann.h"

int main(int argc, char *argv[])
{
	char* p;
	fann_type *calc_out;
	 FILE * out;
	const unsigned int num_input = (int) strtol(argv[5], &p, 10); //14;
	const unsigned int num_output = (int) strtol(argv[6], &p, 10); //9;
	const unsigned int num_layers = (int) strtol(argv[7], &p, 10); //3;
	const unsigned int num_neurons_hidden = (int) strtol(argv[8], &p, 10); //10;
	const float desired_error = (const float) 0.001;
	const unsigned int max_epochs = (int) strtol(argv[9], &p, 10); //500000;
	const unsigned int epochs_between_reports = 1000;
	unsigned 	int numConnections, fibs, fib1=0, fib2=1;

	struct fann *ann;
	struct fann_train_data *data; // *dataTrain;
	struct fann_train_data *dataTest;
	struct fann_train_data *dataValidation;
	struct fann_connection  *connections;

	unsigned int i, j, l, n, noFails=0, fail, prevFail, noRuns;
	float train_error, validation_error, best_validation_error, test_error, best, train_error_avg, validation_error_avg, test_error_avg, bit_fail_avg, fails_avg;

	if(argc<6) {
		printf("Usage: %s <number_of_runs> <train_file> <validation_file> <test_file>", argv[0]);
		exit(0);
	}
	noRuns = (int) strtol(argv[1], &p, 10);
	float fails[noRuns + 1], bit_fails[noRuns + 1];

	printf("noRuns: %d\n", noRuns);
	printf("train_file: %s\n", argv[2]);
	printf("validation_file: %s\n", argv[3]);
	printf("test_file: %s\n", argv[4]);
	printf("num_inputs = %d;  num_outputs = %d;\n", num_input, num_output);
	printf("num_layers = %d;  num_neurons_hidden = %d;\n", num_layers, num_neurons_hidden);
	// Creates a standard fully connected backpropagation neural network.
	ann = fann_create_standard(num_layers, num_input, num_neurons_hidden, num_output);
	// unsigned int layers[4] = {14, 4, 5, 9};
	// ann = fann_create_standard_array(4, layers);

	// Reads a file that stores training data.
	data = fann_read_train_from_file(argv[2]);

	// Set the activation function for all of the hidden layers.
	fann_set_activation_function_hidden(ann, FANN_SIGMOID);
	// Set the activation function for the output layer.
	fann_set_activation_function_output(ann, FANN_SIGMOID);

	// Reads a file that stores training data.
	dataValidation = fann_read_train_from_file(argv[3]);


	train_error_avg=0.0;
	validation_error_avg=0.0;
	test_error_avg=0.0;
	bit_fail_avg=0.0;
	fails_avg=0.0;
	strcat(argv[2],"runs.err");
	out=fopen(argv[2], "w");

	for (l = 1; l <= noRuns; l++) {
		// Initialize the weights using Widrow + Nguyen’s algorithm.
		// This function behaves similarly to fann_randomize_weights.
		srand(fib2);
		fibs=fib1+fib2;
		fib1=fib2;
		fib2=fibs;
		fann_init_weights(ann, data);
		n=0;
		best_validation_error=1;
		printf("run #%d Training network.\n",l);
		for(i = 1; i <= max_epochs; i++) {
			fann_train_epoch(ann, data);
			train_error = fann_test_data(ann, data);
			validation_error = fann_test_data(ann, dataValidation);
			fprintf(out, "%d	%d	%f	%f\n", l, i, train_error, validation_error);
			if ( validation_error < best_validation_error )
			{
				printf("Save ann network: %f < %f\n", validation_error, best_validation_error);
				numConnections=fann_get_total_connections(ann);
				connections=malloc(sizeof(struct fann_connection) * numConnections);
				fann_get_connection_array(ann, connections);
				// fann_save(ann, "save.net");
				best_validation_error = validation_error;
				n=0;
			}
			n++;
			if ( validation_error <= desired_error ) {
				printf("Got to desired error! ... and from %d itterations validation_error did not changed! \n", n);
				break;
			}
			if (n==10000) {
				printf("validation_error: %f @ n: %d \n", validation_error, n);
			}
		}

		// End of trainig ... start of testing ...

		// ann = fann_create_from_file("save.net");
		fann_set_weight_array(ann, connections, numConnections);
		free(connections);
		if(!ann)
		{
			printf("Error creating ann --- ABORTING.\n");
			return 0;
		}

		dataTest = fann_read_train_from_file(argv[4]);
		prevFail=0;
		noFails=0;
		fann_reset_MSE(ann);
		// fann_test_data(ann, dataTest);
		for(i = 0; i < fann_length_train_data(dataTest); i++)
		{

			calc_out = fann_test(ann, dataTest->input[i], dataTest->output[i]);
			printf("\n\t calcOUT(");

			for(j = 0; j<= sizeof(calc_out); j++)
			{
				printf(" %f", calc_out[j]);
			}

			printf(")\n\t expectOut(");
			for(j = 0; j<= sizeof(dataTest->output[i]); j++)
			{
				printf(" %f", dataTest->output[i][j]);
			}
			printf(")\n");
			printf("» #%d trainErr: %f validErr: %f testErr: %f bit_fail: %d fails: %d / %d\n", l, train_error, validation_error, fann_get_MSE(ann), fann_get_bit_fail(ann), noFails, fann_length_train_data(dataTest));
			fails[l]=noFails;
			bit_fails[l]=fann_get_bit_fail(ann);
			fail=fann_get_bit_fail(ann);
			if(fail> prevFail) noFails++;
			prevFail=fail;
		}
		printf("Testing network.\n");
		printf("#%d trainErr: %f validErr: %f testErr: %f bit_fail: %d fails: %d / %d\n", l, train_error, validation_error, fann_get_MSE(ann), fann_get_bit_fail(ann), noFails, fann_length_train_data(dataTest));
		train_error_avg+=train_error;
		validation_error_avg+=validation_error;
		test_error_avg+=(float) fann_get_MSE(ann);
		bit_fail_avg+=(float) fann_get_bit_fail(ann);
		fails_avg+=(float) noFails;
	}
	fclose(out);

	// printf("Averages OF trainErr: %f validErr: %f testErr: %f bit_fail: %f fails: %f\n", train_error_avg/noRuns, validation_error_avg/noRuns, test_error_avg/noRuns, bit_fail_avg/noRuns, fails_avg/noRuns);
float meanFail=((fails_avg/noRuns)*100)/fann_length_train_data(dataTest);
float step;
float stdDev=0, sum=0, min=fails[1];

	for (l = 1; l <= noRuns; l++) {
		step=(fails[l]-fails_avg/noRuns)*(fails[l]-fails_avg/noRuns);
		sum+=step;
		if(fails[l]<min) min=fails[l];
	}
	stdDev=sqrtf(sum/noRuns);
	printf("TOT%d: trainErr:	validErr:	testErr:	bit_fail:	fails:		minFail: 		meanFail:	stdDevFail:\n", noRuns);
	printf("TOT%d: %f	%f	%f	%f	%f	%f(%f)	%f	%f\n", noRuns, train_error_avg/noRuns, validation_error_avg/noRuns, test_error_avg/noRuns, bit_fail_avg/noRuns, fails_avg/noRuns, min, ((min*100)/fann_length_train_data(dataTest)), meanFail, stdDev);
	// printf("")

	printf("Saving network.\n");

	printf("Cleaning up.\n");
	fann_destroy_train(data);
	fann_destroy_train(dataTest);
	fann_destroy_train(dataValidation);
	// Destroys the entire network, properly freeing all the associated memory.
	fann_destroy(ann);

	return 0;
}
