sed 's/[.,:;!?"-/@#$%^&*()]/ /g' $1 | sed "y/ŞşŢţ„—“[]'’/șșțț       /" | sed 'y/AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVXYZW/aăâbcdefghiîjklmnopqrsștțuvxyzw/' > $2
awk '{n=n+NF; for(i=1;i<=NF;i++) {x[$i]++; if(max<=x[$i]){max=x[$i];}}}END{ for(i in x) printf("%f %d/%d= %f %s\n",  x[i]/max,  x[i], n, (x[i]*100)/n,  i)}' $2 | sed  's/  */ /g' | sort -nr
