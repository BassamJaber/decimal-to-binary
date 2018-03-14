#!/bin/sh

#Test if the number of Arguments correct 
if [ "$#" -ne 1 ] 
then 
  echo "Usage: $0  Decimal Number "
  exit 1     
fi

# this might give a Warning because it is Used For Integer not Decimal Number with Fraction

if [ $(echo "$1 < 0" | bc) -ne 0 ] 
then 
  echo "Error: ($1)  must be positive Decimal Number "
  exit 2     
fi

#i will use temporary file to Cut the number into fraction number and Integer Number

echo "$1" >>temp
fraction=$(cut -d'.' -f2 temp)
integer=$(cut -d'.' -f1 temp)
rm temp

#now we will convert fraction part into a fraction again
echo $fraction >>temp
size=`cut -d' ' -f1 temp | wc -c `
# always number of character include EOF so Real Size -1
rm temp
#convert the number again to fraction
size=$((size - 1))
j=0
value=1

while [ "$j" -ne "$size" ]
do
   value=$((value \* 10))
   j=$((j+1))
done 

fraction=$(echo "$fraction / $value " | bc -l)

#echo $fraction

# i will implement it as same as the C Code

base=1
result=0
remain=0

while [ "$integer" -gt 0 ]
do
   remain=$(($integer % 2))
   result=$((result + remain \* base))
   base=$((base \* 10))
   integer=$((integer / 2 ))
done

#echo $result


i=0
fbase=0.1
cons=0.1   # used for multiplying
fresult=0
remain=0
temp=0
two=2
 
# we took the fraction as integer so we must devide it by it's length 

echo "fraction is $fraction"  
  
# there is a Problem with Dealing with fraction in conditinals 

#$( echo "$fraction  > 0" | bc -l)
#"$fraction" 
while [ "$fraction" -ne 0 -a "$i" -lt 9 ]
do
  #temp=$((fraction \* 2))
  temp=$( echo "$temp \* $two" | bc -l)
  if [ "$temp" -ge 1 ]
   then 
      fresult=$((1 \* fbase))
      #fbase=$((fbase \* cons))
      fbase=$( echo "$fbase \* $cons" | bc -l)
      fraction=$((temp - 1))
   else
      #fbase=$((fbase \* cons))
      fbase=$( echo "$fbase \* $cons" | bc -l)
      fraction=$temp
  fi

i=$((i+1))
done

#echo $fresult

answer=$( echo "$result + $fresult" | bc -l)

echo "Decimal Value : $1 \nBinary Value $answer\n"
