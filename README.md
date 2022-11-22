# ROST-source-code
## Context:

The source code was written for the tests described in the paper called "[A comparison of several AI techniques for authorship attribution on Romanian texts](https://www.researchgate.net/publication/365299177_A_comparison_of_several_AI_techniques_for_authorship_attribution_on_Romanian_texts)". Here, several AI techniques were compared for classifying literary texts written by multiple authors by taking into account a limited number of speech parts (prepositions, adverbs, and conjunctions). The dataset contains 400 Romanian texts written by 10 authors and it can be foud at: [https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts](https://www.kaggle.com/datasets/sandamariaavram/rost-romanian-stories-and-other-texts). The compared methods are Artificial Neural Networks, Multi Expression Programming, k-Nearest Neighbour, Support Vector Machines, and Decision Trees with C5.0. 

## Content:

### The dataset
* ROST.csv - contains detailed information about the year of publishing, type of writing, title, author and (website) source of the text for all 400 texts 
* start.sh - is a bash script used to start generating the dataset representation based on the files from directory 'dataIn' and the given Infexible Parts of Speec(IPoS) from 'dataIPoS'; the outputs are placed into '*sets/' directories
* dataIn/ - text files containing the texts to process; here two examples are given
* dataIPoS/ - files containing lists of IPoS; here we have:
    * dataIPoS/adverbs
    * dataIPoS/prepositions
    * dataIPoS/conjunctions
    * dataIPoS/interjections
* bin/ - programs used to convert the text files into char and word frequencies
    * bin/config.sh - configuration file setting directory and filenames for input and output processing
    * bin/analyse.sh - main bash script that converts the files into files containing char and word frequencies (includes config.sh and uses freq.c and wordFrequency.sh)
    * bin/freq.c - POSIX c file used to compute the frequency of chars
    * bin/wordFrequency.sh - bash script used to compute the frequency of words
    * bin/prepareForMepx.sh - takes files from the files that were output from 'bin/analyse.sh' and generates train-validation-test files in MEPX format in the 'MEPsets/' directory
    * bin/convertMepx2FANN.sh - bash script used to convert from MEPX format into FANN format
    * bin/convertMepx2kNN.sh - bash script used to convert from MEPX format into FANN format
    * bin/convertMepx2SVM.sh - bash script used to convert from MEPX format into LIBSVM format
    * bin/convertMepx2C50.sh - bash script used to convert from MEPX format into C5.0 format

#### Dataset processing output
* dataProc_sample/ - sample of a dataProc/ directory that will be generated by running 'bin/analyse.sh'
    * dataProc_sample/Oltean_AbiaAstept/charFreq.txt - the top of char frequencies 
    * dataProc_sample/Oltean_AbiaAstept/fileToProcess.txt - the text file prepared by replacing ŞşŢţ’„“”—–― with ȘșȚț'\"\"\"--- and consecutive white spaces with one space
    * dataProc_sample/Oltean_AbiaAstept/fileToProcessAlphaNum.txt - text file containing only alphanumeric chars
    * dataProc_sample/Oltean_AbiaAstept/iposFreq.txt - list of frequency of occurence of the IPoSs specified; in this case all were used 
    * dataProc_sample/Oltean_AbiaAstept/textWithCharFreq.txt
    * dataProc_sample/Oltean_AbiaAstept/wordFreq.txt - top of word frequencies
    
 * MEPsets_sample/ - sample of a MEPsets/ directory that will be generated by running 'bin/prepareForMepx.sh'
     * MEPsets/IPoS/2022-11-22-15-20_trainSetX - (where X is 1, 2 or 3) - train files generated based on all data from 'dataProc/'
     * MEPsets/IPoS/2022-11-22-15-20_validSetX - (where X is 1, 2 or 3) - validation files generated based on all data from 'dataProc/'
     * MEPsets/IPoS/2022-11-22-15-20_testSetX - (where X is 1, 2 or 3) - test files generated based on all data from 'dataProc/'
     * MEPsets/IPoS/all-IPoS.txt - all IPoSs that occur in all texts from 'dataProc/'
     * MEPsets/IPoS/auth and MEPsets/IPoS/auth_SurName - auxiliary files used to shuffle files for an author
     * MEPsets/IPoS/countStats-IPoS.csv - stats (No_IPoS;No_lines;No_words;No_chars;No_UniqueWords;No_UniqueChars) regarding the texts from 'dataProc/'
     * MEPsets/IPoS/Stats-IPoS.csv - IPoS stats used to know how many texts per author and how are they distributed into train-validation-test sets (50%-25%-25%)

* FANNsets_sample/ - sample of a FANNsets/ directory that will be generated by running 'bin/convertMepx2FANN.sh'
* kNNsets_sample/ - sample of a kNNsets/ directory that will be generated by running 'bin/convertMepx2kNN.sh'
* SVMsets_sample/ - sample of a SVMsets/ directory that will be generated by running 'bin/convertMepx2SVM.sh'
* DT_C5.0sets_sample/ - sample of a DT_C5.0sets/ directory that will be generated by running 'bin/convertMepx2C50.sh'
     
    
    

### ANN - using FANN

### MEP - using MEPX software

### kNN

### SVM - using LIBSVM

### Decision trees - using C5.0

## Contact:

Sanda Avram

[sanda.avram@ubbcluj.ro](sanda.avram@ubbcluj.ro)
