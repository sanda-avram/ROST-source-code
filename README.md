# ROST-source-code
## Context:

The source code was written for the tests described in the paper called "[A comparison of several AI techniques for authorship attribution on Romanian texts](https://www.researchgate.net/publication/365299177_A_comparison_of_several_AI_techniques_for_authorship_attribution_on_Romanian_texts)". Here, several AI techniques were compared for classifying literary texts written by multiple authors by taking into account a limited number of speech parts (prepositions, adverbs, and conjunctions). The dataset contains 400 Romanian texts written by 10 authors and it can be found at: [https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts](https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts). The compared methods are Artificial Neural Networks, Multi Expression Programming, k-Nearest Neighbour, Support Vector Machines, and Decision Trees with C5.0.

## Content:

* [code-for-ANN/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/) - programs for running FANN
    * [code-for-ANN/my_trainValidTest_seedFib.c](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/my_trainValidTest_seedFib.c) - POSIX C source file; uses libfann to build and use an ANN; Fibonacci sequence is used to generate random seeds
    * [code-for-ANN/30runs_param_seed_neur.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/30runs_param_seed_neur.sh) - bash script for setting some parameters, compiling [code-for-ANN/my_trainValidTest_seedFib.c](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/my_trainValidTest_seedFib.c) using [code-for-ANN/Makefile](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/Makefile), creating the output directory and calling [code-for-ANN/showResults.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/showResults.sh) to display the results
    * [code-for-ANN/showResults.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-ANN/showResults.sh) - display the results based on the data collected in the output directory; `myOut/` is the default output directory
* [code-for-MEP/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-MEP/) - projects to be open with `MEPX Software`. These projects include the datasets as well as the parameters that were used
    * [code-for-MEP/](https://github.com/sanda-avram/ROST-source-code/tree/main/data-preprocessing/code-for-MEP/)`ROST-P-MEPX-X.xml` - (where X is 1, 2 or 3) -  `MEPX` project for the 3 representations pf the dataset considering prepositions
    * [code-for-MEP/](https://github.com/sanda-avram/ROST-source-code/tree/main/data-preprocessing/code-for-MEP/)`ROST-PA-MEPX-X.xml` - (where X is 1, 2 or 3) - `MEPX` project for the 3 representations pf the dataset considering prepositions and adverbs
    * [code-for-MEP/](https://github.com/sanda-avram/ROST-source-code/tree/main/data-preprocessing/code-for-MEP/)`ROST-PAC-MEPX-X.xml` - (where X is 1, 2 or 3) - `MEPX` project for the 3 representations pf the dataset considering prepositions, adverbs and conjunctions
* [code-for-kNN/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-kNN/) - programs for kNN
    * [code-for-kNN/KNN.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-kNN/KNN.sh) - bash script which based on training and test data and a value of k determines a class using Euclidean distance
    * [code-for-kNN/doKNN.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-kNN/doKNN.sh) - bash script to automate running [code-for-kNN/KNN.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-kNN/KNN.sh) with k from 1 to 30 and then computing the error rate
* [code-for-SVM/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-SVM/) - programs for SVM
    * [code-for-SVM/doSVM.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-SVM/doSVM.sh) - bash script to automate running `libsvm` and then computing the error rate
* [code-for-DT_C5.0/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-DT_C5.0/doC50.sh) - programs for DT_C5.0
    * [code-for-DT_C5.0/doC50.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-DT_C5.0/doC50.sh) - bash script to automate running `C5.0` with -m cases from 1 to 30 and then showing the error rates in reverse order
* [data-preprocessing/](https://github.com/sanda-avram/ROST-source-code/blob/main/data-preprocessing/) - programs and samples for processing the text files and transform them into numerical vector representation sets to be processed by ANN, MEP, kNN, SVM and DT with C5.0 (details are provided in [data-preprocessing/README.md](https://github.com/sanda-avram/ROST-source-code/blob/main/data-preprocessing/README.md))

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

### MEP - using MEPX software

Install MEPX Software from [https://mepx.org/mepx_software.html](https://mepx.org/mepx_software.html). It has a friendly, graphical interface that is easy to use. One can use the projects provided in [code-for-MEP/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-MEP/) by loading them directly in [MEPX](https://mepx.org/mepx_software.html), or run the tests by setting the parameters as detailed in "[A comparison of several AI techniques for authorship attribution on Romanian texts](https://www.researchgate.net/publication/365299177_A_comparison_of_several_AI_techniques_for_authorship_attribution_on_Romanian_texts)" and use the files generated in `MEPsets/` or the ones provided on [Kaggle](https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts).

### kNN

To use, first you have to navigate to the kNN directory:

```bash
    cd code-for-kNN
```

After that, just run:

```bash
    bash doKNN.sh
```

### SVM - using LIBSVM

To use, first you have to navigate to the FANN directory:

```bash
    cd code-for-SVM
```

Then, please install libsvm from [https://github.com/cjlin1/libsvm](https://github.com/cjlin1/libsvm). Usually libsvm installs in `libsvm-master` directory.

Then, just run:

```bash
    bash doSVM.sh
```

If libsvm installed in another directory, then give the name of that directory as parameter to the previous command.

### Decision trees - using C5.0

To use, first you have to navigate to the DT_C5.0 directory:

```bash
    cd code-for-DT_C5.0
```

Then, please install C5.0 from [https://www.rulequest.com/download.html](https://www.rulequest.com/download.html). Usually libsvm installs in `C50` directory.


Then, just run:

```bash
    bash doC50.sh
```

If C5.0 installed in another directory, then give the name of that directory as parameter to the previous command.


To see the results ordered in reverse order, run:

```bash
    bash doC50.sh C50 rez
```

## Contact:

Sanda Avram

[sanda.avram@ubbcluj.ro](sanda.avram@ubbcluj.ro)
