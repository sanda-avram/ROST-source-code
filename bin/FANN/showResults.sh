
dir=${1-"myOut"}

if [ -n "$3" ]
then
  if [ "$2" != "stats" ]
  then
  # show details /  run
  grep "Err" $3 | grep -v "»"| grep -v "TOT"

  # show header
  grep "TOT \t trainErr:" $3 |head -n1;
  grep "TOT" $3 |grep -v "Err"
  fi
  echo "runs: neurons:  trainErr:	validErr:	testErr:	bit_fail:		fails:		minFails:		stdDevFail:"
  grep "TOT" $3 |grep -v "Err"| awk '{split($1,a,"-"); split(a[6],b,":"); split($7,c,"(");
  print substr(b[2],4),"\t", substr(b[1],3),"\t",$2,"\t", $3,"\t", $4,"\t", $5,"\t", substr($8,0,5),"% ("substr($6,0,5)"/98)\t", substr(c[2],0,5),"% ("substr(c[1],0,5)"/98)\t",$9 }'
else
  if [ "$2" != "stats" ]
  then
  # show details /  run
  grep "Err" ${dir}/* | grep -v "»"| grep -v "TOT"

  # show header
  grep "TOT \t trainErr:" ${dir}/* |head -n1;
  grep "TOT" ${dir}/* |grep -v "Err"
  fi
  echo "runs: neurons:  trainErr:	validErr:	testErr:	bit_fail:		fails:		minFails:		stdDevFail:"
  grep "TOT" ${dir}/* |grep -v "Err"| awk '{split($1,a,"-"); split(a[6],b,":"); split($7,c,"(");
  print substr(b[2],4),"\t", substr(b[1],3),"\t",$2,"\t", $3,"\t", $4,"\t", $5,"\t", substr($8,0,5),"% ("substr($6,0,5)"/98)\t", substr(c[2],0,5),"% ("substr(c[1],0,5)"/98)\t",$9 }'
fi
