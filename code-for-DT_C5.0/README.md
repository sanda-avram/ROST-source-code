# ROST-source-code
## [code-for-DT_C5.0/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-DT_C5.0/)

## Content:

* [code-for-DT_C5.0/](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-DT_C5.0/doC50.sh) - programs for DT_C5.0
    * [code-for-DT_C5.0/doC50.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-DT_C5.0/doC50.sh) - bash script to automate running `C5.0` with -m cases from 1 to 30 and then showing the error rates in reverse order
* [data-preprocessing/](https://github.com/sanda-avram/ROST-source-code/blob/main/data-preprocessing/) - programs and samples for processing the text files and transform them into numerical vector representation sets to be processed by ANN, MEP, kNN, SVM and DT with C5.0 (details are provided in [data-preprocessing/README.md](https://github.com/sanda-avram/ROST-source-code/blob/main/data-preprocessing/README.md))

## To USE

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