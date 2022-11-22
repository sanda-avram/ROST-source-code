if [ -f config.sh ]
then
  echo "File config.sh missing!"
  exit 3
fi
source bin/config.sh
echo "Start ...."
if [ -d $dirName ]
  then
    rm -rf $dirName
    echo "... deleting "$dirName
  fi
mkdir -p $dirName
echo "... creating "$dirName

sed "y/ŞşŢţ’„“”—–―/ȘșȚț'\"\"\"---/" $fileName |sed 's/…/.../g' | tr "\t" " "| tr "\n\n" "\n"| sed  's/[[:blank:]]\{1,\}/ /g' > $fileToProcess
echo "... normalize the file "$fileName "
      replacing ŞşŢţ’„“”—–― with ȘșȚț'\"\"\"--- and consecutive white spaces with one space
        » "$fileToProcess

if [ ! -x "bin/freq" ]
then
  if [ ! -f "bin/freq.c" ]
  then
    echo "File bin/freq.c missing!"
    exit 1
  fi
  gcc bin/freq.c -o bin/freq
fi
./bin/freq $fileToProcess $fileTextWithCharFreq > $fileTemp
sort -nr $fileTemp |\
    sed 's/^\([0-9 ./=]* (179)\).*/\1 –/'|\
    sed 's/^\([0-9 ./=]* (325)\).*/\1 Â/'|\
    sed 's/^\([0-9 ./=]* (326)\).*/\1 Ă/'|\
    sed 's/^\([0-9 ./=]* (327)\).*/\1 ă/'|\
    sed 's/^\([0-9 ./=]* (337)\).*/\1 Î/'|\
    sed 's/^\([0-9 ./=]* (352)\).*/\1 Ș/'|\
    sed 's/^\([0-9 ./=]* (353)\).*/\1 ș/'|\
    sed 's/^\([0-9 ./=]* (354)\).*/\1 Ț/'|\
    sed 's/^\([0-9 ./=]* (355)\).*/\1 ț/'|\
    sed 's/^\([0-9 ./=]* (357)\).*/\1 â/'|\
    sed 's/^\([0-9 ./=]* (369)\).*/\1 î/'|\
    sed 's/^\([0-9 ./=]* (346)\).*/\1 ŕ/'> $fileCharFreq
rm $fileTemp
echo "... generate char frequency
        » "$fileTextWithCharFreq"
        » "$fileCharFreq



  bash bin/wordFrequency.sh $fileToProcess $fileToProcessAlphaNum> $fileWordFreq
  maxWordFreq=`head -1 $fileWordFreq | cut -d" " -f1`


echo "... generate word frequency
        » "$fileWordFreq

shift
# for w in `cat conjunctions prepositions interjections`
for w in `cat $*  | sort -u`
do
  grep " $w$" $fileWordFreq >> $fileIPoSFreq
done

echo "... generate $* frequency
        » "$fileIPoSFreq

echo ""
rm -rf $fileTemp
