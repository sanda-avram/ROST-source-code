dataDir="../data-preprocessing/SVMsets"
codeDir=${1-"libsvm-master"}

# if [ ! -d $dataDir ]
# then
#   bash ../convertMepx2SVM.sh
# else
  for f in `ls -1 $dataDir |grep "trainSet"`
  do
    file=$dataDir"/"$f
    if [ -f $file ]
    then
      echo "Results for: "$file
      mf=`echo $file|sed 's/train/model/g' `
      trf=`echo $file|sed 's/train/trainResults/g' `
      ./${codeDir}/svm-train -s 1 -t $1 -n $2 $file $mf > $trf
      tf=`echo $file|sed 's/train/test/g' `
      of=`echo $file|sed 's/train/out/g' `
      tsrf=`echo $file|sed 's/train/testResults/g' `
      echo "-t $1 -n $2" >> $tsrf
      ./${codeDir}/svm-predict $tf $mf $of >> $tsrf
    fi
  done
# fi

for f in `ls -1 $dataDir |grep "testResults"`
do
  echo "For ..."$dataDir"/"$f
  cat $dataDir"/"$f
  cat $dataDir"/"$f | tail -n1 | sed 's_[/()]_ _g'| awk '{val=$4; size=$5; print "Error rate: "(100-(100*val)/size)"%"}'
done
