# ROST-source-code

## Content of `code-for-ANN/`:

* programs for running FANN:
    * [my_trainValidTest_seedFib.c](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/my_trainValidTest_seedFib.c) - POSIX C source file; uses libfann to build and use an ANN; Fibonacci sequence is used to generate random seeds
    * [30runs_param_seed_neur.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/30runs_param_seed_neur.sh) - bash script for setting some parameters, compiling [my_trainValidTest_seedFib.c](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/my_trainValidTest_seedFib.c) using [Makefile](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/Makefile), creating the output directory and calling [showResults.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/showResults.sh) to display the results
    * [showResults.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/showResults.sh) - display the results based on the data collected in the output directory; `myOut/` is the default output directory

## To USE


### ANN - using FANN

 Fast Artificial Neural Network (FANN) library was used for ANN. See source code at [https://github.com/libfann/fann](https://github.com/libfann/fann).

To use, first you have to navigate to the FANN directory:

```bash
    cd code-for-ANN
```

Then, please install [libfann](https://github.com/libfann/fann) in the `src/` directory after you can create it with:

```bash
    mkdir src
```

After that, just run:

```bash
    bash 30runs_param_seed_neur.sh 2022-10-19-22-09 1
```


 where the first parameter `2022-10-19-22-09` is the start of the filename of the FANN format files from `FANNsets/` so that the specific files can be identified, and the second parameter `1` represents the end of the filename of the FANN format files to identify the shuffle.

 If one wants to run uninterruptedly even after exiting the shell or terminal, use:

 ```bash
     nohup bash 30runs_param_seed_neur.sh 2022-10-19-22-09 1 > runs_1.out &
 ```

## Contact:

Sanda Avram

[sanda.avram@ubbcluj.ro](sanda.avram@ubbcluj.ro)
