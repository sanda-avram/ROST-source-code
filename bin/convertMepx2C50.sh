subdir=`echo ${1-"IPoS"} |awk '{print $1}'| awk -F/ '{print $2}'`
dir=`echo ${1-"MEPsets"} |awk '{print $1}'| awk -F/ '{print $1}'`
inDir=$dir"/"$subdir
outDir="DT_C5.0sets"
if [ ! -d $outDir ]
then
  mkdir $outDir
fi
echo "source dir: "$inDir
echo "destination dir: "$outDir

inFile=${*-$inDir"/*"}
# build names
inNames=$inDir"/all-*.txt"
names=`ls -1 $inNames|awk '{print $1}'`
echo "source names: "$names
C50namesFile=$outDir"/"`echo $inFile| grep "_trainSet"|awk '{print $1}'| awk -F/ '{print $NF}'| sed 's/test//g'`".names"
echo "destination names: "$C50namesFile
echo "author.                     | the target attribute
"> $C50namesFile
for word in `cat $names`
do
  echo $word":                           continuous." >> $C50namesFile
done
echo "
author:                           0,1,2,3,4,5,6,7,8,9.

ID:                            label." >> $C50namesFile
C50namesFile2=`echo $C50namesFile | sed 's/1\.names$/2\.names/g'`
C50namesFile3=`echo $C50namesFile | sed 's/1\.names$/3\.names/g'`
cp $C50namesFile $C50namesFile2
cp $C50namesFile $C50namesFile3

# build data and test
for f in `ls -1 $inFile| grep "_trainSet"`
do
  echo $f
  trainFileName=`basename $f`
  testFileName=`echo $trainFileName | sed 's/train/test/g'`
  cat $f | sed 's/ /,/g' > $outDir"/tempFile"
  cat `echo $f | sed 's/train/valid/g'` | sed 's/ /,/g' >> $outDir"/tempFile"

  awk '{i++; print $0","i}' $outDir"/tempFile" > $outDir"/"`echo $trainFileName| sed 's/train//g'`".data"
  cat `echo $f | sed 's/train/test/g'` | sed 's/ /,/g' > $outDir"/tempFile"
  awk '{i++; print $0","i}' $outDir"/tempFile" > $outDir"/"`echo $testFileName| sed 's/test//g'`".test"

done
rm -rf $outDir"/tempFile"
