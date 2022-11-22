inDir="MEPsets/IPoS/"
outDir="SVMsets"
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
  awk '{line=""$NF; for ( i = 1; i < NF; i++ ) line=line" "i":"$i;print line}' $f > $outDir"/"$trainFileName
  awk '{line=""$NF; for ( i = 1; i < NF; i++ ) line=line" "i":"$i;print line}' `echo $f | sed 's/train/valid/g'` >> $outDir"/"$trainFileName
  awk '{line=""$NF; for ( i = 1; i < NF; i++ ) line=line" "i":"$i;print line}' `echo $f | sed 's/train/test/g'` > $outDir"/"$testFileName

done
