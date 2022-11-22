dir="../../kNNsets"

if [ -d $dir ]
then
  areFiles=0
  for f in `ls -1 $dir |grep "trainSet"`
  do
    file=$dir"/"$f
    if [ -f $file ]
    then
      echo "Results for: "$file
      tf=`echo $file|sed 's/train/test/g' `
      r=`echo $file|sed 's/train/result/g' `
      rm -rf $r
      if [ -f $tf ]
      then
        echo "... and "$tf
        areFiles=1
        for k in `seq 1 30`
        do
          bash KNN.sh $file $tf $k >> $r
          tail -n1 $r
        done
      fi
    fi
  done
fi

for f in `ls -1 $dir |grep "resultSet"`
do
  echo "For ..."$dir"/"$f
  cat $dir"/"$f | grep "Found" | sort -nrk2 |head -n1| awk '{val=$2; size=$5; print "Error rate: "(100.00-(100*val)/size)}'
  # val=`cat $dir"/"$f | grep "Found" | sort -nrk2 |head -n1| cut -d" " -f2`
  # upVal=`expr $val \* 100`
  # size=`cat $dir"/"$f | grep "Found" | sort -nrk2 |head -n1| cut -d" " -f11`
  # echo "Success rate: "`expr $upVal / $size`"%"
done


# if [ "$areFiles" -eq 0 ]
# then
#   bash convertMepx2KNN_manhat.sh
#   bash $0
# fi
