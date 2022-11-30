if [ $# -lt 3 ]
then
  echo "Usage: $0 <trainFile> <testFile> <max-value-for-K>"
  exit 1
fi
if [ ! -f $1 ]
then
  echo "$1 is not a file!"
  echo "Usage: $0 <trainFile> <testFile>"
  exit 1
fi
if [ ! -f $2 ]
then
  echo "$2 is not a file!"
  echo "Usage: $0 <trainFile> <testFile>"
  exit 1
fi
trainFile=$1
testFile=$2
# maxK=$3
k=$3
noTests=`cat $testFile| wc -l `
noFound=0
while read -r line
do
  echo "compare .... $line"
  authorInTest=`echo $line| sed 's/.* \([0-9.]*\)$/\1/g'`
  awk -v l="$line" 'BEGIN{split(l,a);}{x=0; for ( i = 1; i < NF; i++ ){ x+=(a[i]-$i)*(a[i]-$i);}  print sqrt(x), NR, $NF;}' $1 | sort > temp
  foundAuthor=`cat temp | head -n $k |\
  awk -v auth="authorInTest" '{x[$NF]++}END{for (i in x) print x[i], i}' | sort -rn | head -n 1 | awk '{print $NF}'`
   echo "authorInTest is $authorInTest ... and the found Author is $foundAuthor"

  if [ "$authorInTest" -eq "$foundAuthor" ]
  then
    noFound=`expr $noFound + 1`
  fi

done < $testFile

echo "Found $noFound Authors from $noTests tests ... with K=$k!"
rm -rf temp
