# ROST-source-code
## Context:

The source code was written for the tests described in the paper called "[A comparison of several AI techniques for authorship attribution on Romanian texts](https://www.researchgate.net/publication/365299177_A_comparison_of_several_AI_techniques_for_authorship_attribution_on_Romanian_texts)". Here, several AI techniques were compared for classifying literary texts written by multiple authors by taking into account a limited number of speech parts (prepositions, adverbs, and conjunctions). The dataset contains 400 Romanian texts written by 10 authors and it can be foud at: [https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts](https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts). The compared methods are Artificial Neural Networks, Multi Expression Programming, k-Nearest Neighbour, Support Vector Machines, and Decision Trees with C5.0. 

## Content:

### The dataset
* `ROST.csv` - details about the 400 texts, such as: year of publishing, type of writing, title, author and (website) source
* `dataIn/` - text files containing the texts to process; here two examples are given
* `dataIPoS/` - files containing lists of IPoS; here we have:`adverbs`, `prepositions`, `conjunctions` and `interjections`

### Programms
* `start.sh` - bash script to generate the dataset representations based on the files from `dataIn/` and the given Infexible Parts of Speec(IPoS) from `dataIPoS/`; the outputs are placed into `*sets/` directories

* `bin/` - programs; bash scripts and POSIX C source files
    * `bin/config.sh` - configuration file setting directory and filenames for input and output processing
    * `bin/analyse.sh` - main bash script that converts the files into files containing char and word frequencies (includes `config.sh` and uses `freq` and `wordFrequency.sh`)
    * `bin/freq.c` - POSIX c file used to compute the frequency of chars
    * `bin/wordFrequency.sh` - bash script used to compute the frequency of words
    * `bin/prepareForMepx.sh` - takes files from the files that were output from `bin/analyse.sh` and generates train-validation-test files in MEPX format in the `MEPsets/` directory
    * `bin/convertMepx2FANN.sh` - bash script used to convert from MEPX format into FANN format
    * `bin/convertMepx2kNN.sh` - bash script used to convert from MEPX format into FANN format
    * `bin/convertMepx2SVM.sh` - bash script used to convert from MEPX format into LIBSVM format
    * `bin/convertMepx2C50.sh` - bash script used to convert from MEPX format into C5.0 format
    * `bin/FANN/` - programs for running FANN
        * `bin/FANN/my_trainValidTest_seedFib.c` - POSIX C source file; uses libfann to build and use an ANN; Fibonacci sequence is used to generate random seeds
        * `bin/FANN/30runs_param_seed_neur.sh` - bash script for setting some parameters, compiling `bin/FANN/my_trainValidTest_seedFib.c` using `bin/FANN/Makefile`, creating the output directory and calling `bin/FANN/showResults.sh` to display the results
        * `bin/FANN/showResults.sh` - display the results based on the data collected in the output directory; `myOut/` is the default output directory
    
### Dataset processing output
* `dataProc_sample/` - sample of a `dataProc/` directory that will be generated by `bin/analyse.sh`
    * `dataProc_sample/Oltean_AbiaAstept/charFreq.txt` - the top of char frequencies 
    * `dataProc_sample/Oltean_AbiaAstept/fileToProcess.txt` - the text file prepared by replacing ŞşŢţ’„“”—–― with ȘșȚț'\"\"\"--- and consecutive white spaces with one space
    * `dataProc_sample/Oltean_AbiaAstept/fileToProcessAlphaNum.txt` - text file containing only alphanumeric chars
    * `dataProc_sample/Oltean_AbiaAstept/iposFreq.txt` - list of frequency of occurence of the IPoSs specified; in this case all were used 
    * `dataProc_sample/Oltean_AbiaAstept/textWithCharFreq.txt`
    * `dataProc_sample/Oltean_AbiaAstept/wordFreq.txt` - top of word frequencies
    
 * `MEPsets_sample/` - sample of a `MEPsets/` directory that will be generated by `bin/prepareForMepx.sh`
     * `MEPsets/IPoS/2022-11-22-15-20_trainSetX` - (where X is 1, 2 or 3) - train files generated based on the content of `dataProc/`
     * `MEPsets/IPoS/2022-11-22-15-20_validSetX` - (where X is 1, 2 or 3) - validation files generated based on the content of `dataProc/`
     * `MEPsets/IPoS/2022-11-22-15-20_testSetX` - (where X is 1, 2 or 3) - test files generated based on the content of `dataProc/`
     * `MEPsets/IPoS/all-IPoS.tx`t - all IPoSs that occur in all texts from `dataProc/`
     * `MEPsets/IPoS/auth` and `MEPsets/IPoS/auth_SurName` - auxiliary files used to shuffle files for an author
     * `MEPsets/IPoS/countStats-IPoS.csv` - stats (No_IPoS;No_lines;No_words;No_chars;No_UniqueWords;No_UniqueChars) regarding the texts from `dataProc/`
     * `MEPsets/IPoS/Stats-IPoS.csv` - IPoS stats used to know how many texts per author and how are they distributed into train-validation-test sets (50%-25%-25%)

* `FANNsets_sample/` - sample of a `FANNsets/` directory that will be generated by `bin/convertMepx2FANN.sh`
* `kNNsets_sample/` - sample of a `kNNsets/` directory that will be generated by `bin/convertMepx2kNN.sh`
* `SVMsets_sample/` - sample of a `SVMsets/` directory that will be generated by `bin/convertMepx2SVM.sh`
* `DT_C5.0sets_sample/` - sample of a `DT_C5.0sets/` directory that will be generated by `bin/convertMepx2C50.sh`
     

## To USE


To create train-validation-test files in formats corresponding to the 5 methods mentioned above starting from text files in `dataIn/` and IPOSs in `dataIPoS/` just run:

      bash start.sh dataIPoS/*



### ANN - using FANN

 Fast Artificial Neural Network (FANN) library was used for ANN. See source code at [https://github.com/libfann/fann](https://github.com/libfann/fann).
    
To use, first you have to navigate to the FANN directory:

    cd bin/FANN
    
Then, please install [libfann](https://github.com/libfann/fann) in the `src/` directory after you can create it with:

    mkdir src

After that, just run:
    
    bash 30runs_param_seed_neur.sh 2022-10-19-22-09 1
    
 where the first parameter `2022-10-19-22-09` is the start of the filename of the FANN format files from `FANNsets/` so that the specific files can be identified, and the second parameter `1` represents the end of the filename of the FANN format files to identify the shuffle.
 
 If one wants to run uninterruptedly even after exiting the shell or terminal, use:
 
     nohup bash 30runs_param_seed_neur.sh 2022-10-19-22-09 1 > runs_1.out &
     

### MEP - using MEPX software

Install MEPX Software from [https://mepx.org/mepx_software.html](https://mepx.org/mepx_software.html). It has a friendly, graphycal interface that is easy to use. Run the tests by setting the parameters as detailed in "[A comparison of several AI techniques for authorship attribution on Romanian texts](https://www.researchgate.net/publication/365299177_A_comparison_of_several_AI_techniques_for_authorship_attribution_on_Romanian_texts)" and use the files generated in `MEPsets/` or the ones provided on Kaggle.

### kNN


### SVM - using LIBSVM

### Decision trees - using C5.0



## Contact:

Sanda Avram

[sanda.avram@ubbcluj.ro](sanda.avram@ubbcluj.ro)
