# subdir=`echo ${1-""} |awk '{print $1}'| awk -F/ '{print $2}'`
outDir="FANNsets/"
inDir="MEPsets/dataIPoS/"
if [ ! -d $outDir ]
then
  mkdir -p $outDir
fi
inFile=${*-$inDir"*Set[123]"}


for fis in `ls -1 $inFile`
do
  # f=${inDir}"/"$fis
  f=$fis
  echo $f
  fileName=`basename $f`
  noLines=`cat $f| wc -l`
  noInputs=`awk '(NR==1){ print NF-1}' $f`
  noOutputs=`awk '{x[$NF]++}END{max=length(x); for (i in x) {if ((i+1)>max) max=i+1}; print max;}' $f`
  echo $noLines" "$noInputs" "$noOutputs > $outDir"/"$fileName
  i=0
  line=""
  for h in `cat $f`
  do
    i=`expr $i + 1`
    if [ $i -gt $noInputs ]
    then
      echo $line >> $outDir"/"$fileName
      line=""
      for k in `seq $noOutputs`
      do
        l=`expr $h + 1`
        if [ $l -eq $k ]
        then
          line=`echo $line" "1`
        else
          line=`echo $line" "0`
        fi
      done
      echo $line >> $outDir"/"$fileName
      i=0
      line=""
    else
      line=`echo $line" "$h`
    fi
  done
done
