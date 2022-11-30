# ROST-source-code

## Content of `code-for-SVM/`:

* programs for SVM:
    * [doSVM.sh](https://github.com/sanda-avram/ROST-source-code/blob/main/code-for-SVM/doSVM.sh) - bash script to automate running `libsvm` and then computing the error rate

## To USE


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

## Contact:

Sanda Avram

[sanda.avram@ubbcluj.ro](sanda.avram@ubbcluj.ro)
