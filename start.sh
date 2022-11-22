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

 bash bin/prepareForMepx.sh
