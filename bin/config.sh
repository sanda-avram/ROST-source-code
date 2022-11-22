fileName=$1
justfileName=`echo $fileName | awk -F'/' '{print $NF}'`
dirName="dataProc/"`echo $justfileName | awk -F'.' '{print $1}'`
fileTemp=$dirName"/temp"
fileToProcess=$dirName"/fileToProcess.txt"
fileToProcessAlphaNum=$dirName"/fileToProcessAlphaNum.txt"
fileTextWithCharFreq=$dirName"/textWithCharFreq.txt"
fileCharFreq=$dirName"/charFreq.txt"
fileTextWithWordFreq=$dirName"/textWithWordFreq.txt"
fileWordFreq=$dirName"/wordFreq.txt"
fileIPoSFreq=$dirName"/iposFreq.txt"
noTopChars=15
title=`grep $justfileName ROST.csv| awk -F',' '{print $5}'`
shortTitle=`grep $justfileName ROST.csv| awk -F',' '{print $1}'`

# statsDir="stats"
