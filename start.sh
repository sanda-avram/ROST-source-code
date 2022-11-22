if [ $2 == "" ]
then
for f in `ls -1 dataIn/*`
 do
   if [ $# -lt 1 ]
   then
     echo "Usage: bash $0 <file-name-from-dataIPoS-directory>"
     exit 1
   fi
   line=""
   for IPoS
   do
      cleanIPoS=`echo $IPoS|sed 's|dataIPoS/||g'`
      # ls -1 dataIPoS | grep $IPoS
      if [ ! -f "dataIPoS/"$cleanIPoS ]
      then
          echo "IPoS should be a file in dataIPoS directory!"
          echo "You can choose:"
          ls -1 dataIPoS
          exit 2
      fi
      line=$line" dataIPoS/"$cleanIPoS
   done
  bash bin/analyse.sh $f $line
 done
fi

 echo " ...... prepareForMepx"
 bash bin/prepareForMepx.sh
 echo " ...... convertMepx2FANN"
 bash bin/convertMepx2FANN.sh MEPsets/IPoS/*Set[123]
 echo " ...... convertMepx2kNN"
 bash bin/convertMepx2kNN.sh MEPsets/IPoS/*Set[123]
 echo " ...... convertMepx2SVM"
 bash bin/convertMepx2SVM.sh MEPsets/IPoS/*Set[123]
 echo " ...... convertMepx2C50"
 bash bin/convertMepx2C50.sh MEPsets/IPoS/*Set[123]
