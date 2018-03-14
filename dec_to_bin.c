#include <stdlib.h>
#include <stdio.h>

int main(int argc , char* argv[]){

 if(argc !=2 ){
   printf("Usage: ./dec_to_bin decimal number \n");
   exit(1);
 }

 double num=atof(argv[1]);

 if(num < 0){
  printf("Error:Number must be Positive\n");
  exit(2);
 }
 
 int IntPart=0;
 double fraction=0;
 IntPart=(int)num;
 fraction=num-IntPart;
 
 unsigned long base=1;
 unsigned int result=0;
 int remainder=0;

 /*Real Part conversion*/
 while(IntPart > 0){  
      remainder=IntPart%2;
      result+=(remainder*base);
      base*=10;
      IntPart=IntPart/2;
 }

   
 /*Fraction Part Conversion*/
  int i=0;
  double fbase=0.1;
  double fresult=0;
  remainder=0;
  double temp=0;

  while( fraction != 0 && i !=9 ){
   temp=fraction*2;
   if(temp >= 1){
      fresult+=1*fbase;
      fbase*=0.1;
      fraction=temp-1;
   }else{
	  fbase*=0.1;
          fraction=temp;
        }
   i++;
 }

double answer=result+fresult;

printf("\nDecimal Value  is : %f\nBinary Value is :%f \n\n",num,answer);
 return 0;
}
