inDir="MEPsets/IPoS/"
outDir="kNNsets"
if [ ! -d $outDir ]
then
  mkdir $outDir
fi

inFile=${*-$inDir"/*"}


for f in `ls -1 $inFile| grep "_trainSet"`
do
  echo $f
  trainFileName=`basename $f`
  testFileName=`echo $trainFileName | sed 's/train/test/g'`
  cat $f > $outDir"/"$trainFileName
  cat `echo $f | sed 's/train/valid/g'` >> $outDir"/"$trainFileName
  cat `echo $f | sed 's/train/test/g'` > $outDir"/"$testFileName

done
