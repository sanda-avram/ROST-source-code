dataDir="../../DT_C5.0sets"
codeDir=${1-"C50"}
n=30
option="-m"

# if [ ! -d $dataDir ]
# then
#   bash convertMepx2C50.sh mepxSets/IPoS/*
# else
    rm -rf temp

    for f in `ls -1 $dataDir |grep ".data"`
    do
      file=$dataDir"/"$f
      if [ -f $file ]
      then
        echo "Results for: "$file
        nmf=`echo $file|sed 's/data$/names/g' `
        tsf=`echo $file|sed 's/data$/test/g' `

        for i in  `seq 1 $n`
        do
          rf=`echo $file|sed 's/data$/REZ'${option}$i'/g' `
          if [ "$2" == "rez" ]
          then
            # echo $rf
            # tail -n20 $rf | head -n1 > head

            echo "          "`tail -n18 $rf | head -n1`"   "$option $i >> temp
          else
            ./${codeDir}/c5.0 ${option} $i -f `echo $file| awk '{print substr($0,1,length-5)}'`> $rf
          fi
        done
        if [ "$2" == "rez" ]
        then
          # cat head
          echo "          Size Error         Option"
          sort -k2n temp
        fi
      fi
    done
    rm -rf temp
    # rm -rf head


# fi
