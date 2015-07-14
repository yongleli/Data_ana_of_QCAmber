#!/bin/bash

### To find the restarted RESP charges from md-*.log files. 
### These RESP charges correspond to the frames stored in *.traj file.
### Helpful to calculate the Stabilizing Interaction Energy.

if [ -e chg-tot.dat ]; then
  rm chg-tot.dat
fi
for i in `seq 0 26`
do
   awk 'BEGIN{x=0;}{ \
        if($5=="q(opt)" && x==0){x=1;l=NR;} \
        if($1~/QChem-Amber/ && $2~/will/ && $3~/write/ && $4~/current/ && $5~/snapshot/){for (j=0;j<30;j++){print chg[j];}print " ";} \
        if(x==1 && NR==l){j=0} \
        if(x==1 && NR>l){chg[j]=$5;echo $5;j=j+1}if(j==30){x=0}}' md-$i.log > chg-$i.dat
   j=`wc chg-$i.dat | awk '{print $1/31}'`
   echo $i   $j
   cat chg-$i.dat >> chg-tot.dat
   rm chg-$i.dat
done
