# bash prepareForMepx.sh conj
# bash prepareForMepx.sh top30-42Word
if [ $# -lt 1 ]
then
  echo "Usage: $0 <type: conj, top30-42Word> [<outDir>]"
  exit
fi
type=$1
dir=${2-"dataProc"}
outDir="mepxSets/"${type}
if [ ! -d $outDir ]
then
  mkdir -p $outDir
fi

fileToProcess="/fileToProcess.txt"
# fileToProcessAlphaNum="/fileToProcessAlphaNum.txt"
# fileTextWithCharFreq="/textWithCharFreq.txt"
fileCharFreq="/charFreq.txt"
# fileTextWithWordFreq="/textWithWordFreq.txt"
fileWordFreq="/wordFreq.txt"
fileConjFreq="/${type}Freq.txt"
allConj=$outDir"/all-${type}.txt"
rm -rf fileTemp


echo "#;Story;No_${type};No_lines;No_words;No_chars;No_UniqueWords;No_UniqueChars" > $outDir"/countStats-${type}.csv"
echo "#;Author;No_stories;len_TrainSet;len_ValidSet;len_TestSet" > $outDir"/Stats-${type}.csv"
i=0
j=0
for d in `ls -1 ${dir}| grep -v "Necunoscut"`
do
  if [ -d ${dir}"/"$d ]
  then
    auth=`echo $d | awk -F"_" '{print $1}'`
    if [ -f ${dir}"/"${d}$fileConjFreq ]
    then
      countNotNull=`awk 'BEGIN{x=0}{if($1>0) x++} END {print x}' ${dir}"/"$d"/"$fileConjFreq`
      if [ $countNotNull -eq 0 ]
      then
        echo "Story: "$d" has 0 ${type}!"
      else
        i=`expr $i + 1`
        echo $i"; "$d"; "$countNotNull"; "`cat ${dir}"/"${d}$fileToProcess|wc -l`"; "`cat ${dir}"/"${d}$fileToProcess|wc -w`"; "`cat ${dir}"/"${d}$fileToProcess|wc -c`"; "`cat ${dir}"/"${d}$fileWordFreq|wc -l`"; "`cat ${dir}"/"${d}$fileCharFreq|wc -l` >> $outDir"/countStats-${type}.csv"
        sort -nr ${dir}"/"${d}$fileConjFreq | awk '{print $NF}' >> fileTemp
        if [ "$auth" = "$prevAuth" ]
        then
            authCount=`expr $authCount + 1`
        else
            if [ $i -gt 1 ]
            then
              c=`expr $authCount + 1`
              qc=`expr $c \* 25`
              qcn=`expr $qc / 100`
              hc=`expr $c - $qcn`
              hcn=`expr $hc - $qcn`
              echo `expr $j - 1`"; "$prevAuth"; "$c"; "$hcn"; "$qcn"; "$qcn >> $outDir"/Stats-${type}.csv"
            fi
            authCount=0
            j=`expr $j + 1`
        fi
      fi
    fi
  fi
  # auth=`echo $d | awk -F"/" '{print $NF}'| awk -F"_" '{print $1}'`
  prevAuth=$auth
done
c=`expr $authCount + 1`
qc=`expr $c \* 25`
qcn=`expr $qc / 100`
hc=`expr $c - $qcn`
hcn=`expr $hc - $qcn`
echo `expr $j - 1`"; "$prevAuth"; "$c"; "$hcn"; "$qcn"; "$qcn >> $outDir"/Stats-${type}.csv"
sort -u fileTemp> $allConj


i=0
prevAuth=""
trainSet1=`date "+%Y-%m-%d-%H-%M"`"_trainSet1"
validSet1=`date "+%Y-%m-%d-%H-%M"`"_validSet1"
testSet1=`date "+%Y-%m-%d-%H-%M"`"_testSet1"
trainSet2=`date "+%Y-%m-%d-%H-%M"`"_trainSet2"
validSet2=`date "+%Y-%m-%d-%H-%M"`"_validSet2"
testSet2=`date "+%Y-%m-%d-%H-%M"`"_testSet2"
trainSet3=`date "+%Y-%m-%d-%H-%M"`"_trainSet3"
validSet3=`date "+%Y-%m-%d-%H-%M"`"_validSet3"
testSet3=`date "+%Y-%m-%d-%H-%M"`"_testSet3"
for f in `awk -F";" 'NR>1{print $2}' $outDir"/countStats-${type}.csv"|sort`
do
  auth=`echo $f | awk -F"_" '{print $1}'`
  if [ "$auth" != "$prevAuth" ]
  then
    i=0
    rm -rf $outDir"/auth_"$auth
    if [ "$prevAuth" != "" ]
    then
      sort -R $outDir"/auth_"$prevAuth > $outDir"/auth"
      head -n $trainLen $outDir"/auth" >> $outDir"/"$trainSet1
      head -n `expr $trainLen + $validLen` $outDir"/auth" | tail -n $validLen >> $outDir"/"$validSet1
      tail -n $testLen $outDir"/auth" >> $outDir"/"$testSet1

      sort -R $outDir"/auth_"$prevAuth > $outDir"/auth"
      head -n $trainLen $outDir"/auth" >> $outDir"/"$trainSet2
      head -n `expr $trainLen + $validLen` $outDir"/auth" | tail -n $validLen >> $outDir"/"$validSet2
      tail -n $testLen $outDir"/auth" >> $outDir"/"$testSet2

      sort -R $outDir"/auth_"$prevAuth > $outDir"/auth"
      head -n $trainLen $outDir"/auth" >> $outDir"/"$trainSet3
      head -n `expr $trainLen + $validLen` $outDir"/auth" | tail -n $validLen >> $outDir"/"$validSet3
      tail -n $testLen $outDir"/auth" >> $outDir"/"$testSet3
    fi
  fi
  # echo $auth
  i=`expr $i + 1`
  index=`grep $auth $outDir"/Stats-${type}.csv"| awk -F";" '{print $1}'`
  trainLen=`grep $auth $outDir"/Stats-${type}.csv"| awk -F";" '{print $4}'`
  validLen=`grep $auth $outDir"/Stats-${type}.csv"| awk -F";" '{print $5}'`
  testLen=`grep $auth $outDir"/Stats-${type}.csv"| awk -F";" '{print $6}'`
  # echo $auth" - "$trainLen" - "$validLen" - "$testLen
  echo $auth"...."$index

  line=""
  for w in `cat $allConj`
  do
    proc=`grep " "${w}$ ${dir}"/"${f}$fileConjFreq |awk '{print ($3/100)}'`
    if [ -z "$proc" ]
    then
      proc="0.000000"
    fi
    line=`echo ${line}" "${proc}`
  done
  # .... put in file to shuffel
  echo $line" "$index >> $outDir"/auth_"$auth
  prevAuth=$auth
done
sort -R $outDir"/auth_"$prevAuth > $outDir"/auth"
head -n $trainLen $outDir"/auth" >> $outDir"/"$trainSet1
head -n `expr $trainLen + $validLen` $outDir"/auth" | tail -n $validLen >> $outDir"/"$validSet1
tail -n $testLen $outDir"/auth" >> $outDir"/"$testSet1

sort -R $outDir"/auth_"$prevAuth > $outDir"/auth"
head -n $trainLen $outDir"/auth" >> $outDir"/"$trainSet2
head -n `expr $trainLen + $validLen` $outDir"/auth" | tail -n $validLen >> $outDir"/"$validSet2
tail -n $testLen $outDir"/auth" >> $outDir"/"$testSet2

sort -R $outDir"/auth_"$prevAuth > $outDir"/auth"
head -n $trainLen $outDir"/auth" >> $outDir"/"$trainSet3
head -n `expr $trainLen + $validLen` $outDir"/auth" | tail -n $validLen >> $outDir"/"$validSet3
tail -n $testLen $outDir"/auth" >> $outDir"/"$testSet3
