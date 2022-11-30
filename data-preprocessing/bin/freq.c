#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <fcntl.h>
/* for constants like EXIT_FAILURE */
#include <stdlib.h>
/* we'll be using standard C I/O to read random bytes */
#include <stdio.h>
#include<string.h>
#define N 400

int x[N];

int main(int argc, char **argv){
 int i, cc, tot, max;
 char c[1], out_f[10], s;
 int fd = open(argv[1], O_RDONLY);
 i=0; // position in the text
 max=0;
 while(read(fd, c, 1)){
   i++;
   if(c[0]>0) {
     cc=(unsigned char) c[0];
   }
   else{
     cc=(unsigned char) c[0];
     read(fd, c, 1);
     cc+=(unsigned char) c[0];
   }
   x[cc]++;
   if(max<=x[cc]){max=x[cc];}
 }
 tot=i;

 for (i=0; i<N; i++) {
  if(x[i]>0) {
     printf("%f %d/%d= %f (%d) %c\n", (float)x[i]/max, x[i], tot, (float)(x[i]*100)/tot, i, i);
  }
 }
 lseek(fd, SEEK_SET, 0);
 i=0;
 FILE* out = fopen(argv[2], "w");
 while(read(fd, c, 1)){
   if((c[0]>0)){
     i++;
     fprintf(out, "%f %d\n",(float)x[c[0]]/max, x[c[0]]);
   }
   if(c[0]<0) {
     i++;
     cc=(unsigned char) c[0];
     read(fd, c, 1);
     cc+=(unsigned char) c[0];
     fprintf(out, "%f %d\n",(float)x[cc]/max,x[cc]);
   }
 }
 close(fd);
 }
