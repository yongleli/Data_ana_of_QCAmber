import numpy as np

PW_list=['r_179_N7_3659.dat',\
'r_179_O16_568.dat',\
'r_179_O17_1435.dat',\
'r_29_O_568.dat',\
'r_37_OH_7430.dat',\
'r_1435_3659.dat',\
'r_568_1435.dat',\
'r_77_O_7430.dat',\
'r_79_N_3659.dat',\
'r_79_O_179_N7.dat',\
'r_79_O_3659.dat',\
'r_QWT_3659.dat',\
'r_QWT_1435.dat',\
'r_QWT_7430.dat',\
'r_29_O_1435.dat']

list_name1=['Ac-CoA@N7',\
'Ac-CoA@O16',\
'Ac-CoA@O17',\
'Q76@O',\
'Y84@OH',\
'W3',\
'W4',\
'A124@O',\
'L126@N',\
'L126@O',\
'L126@O',\
'QWT',\
'QWT',\
'QWT',\
'Q76@O']

list_name2=['W2',\
'W4',\
'W3',\
'W4',\
'W1',\
'W2',\
'W3',\
'W1',\
'W2',\
'Ac-CoA@N7',\
'W2',\
'W2',\
'W3',\
'W1',\
'W3']

def count_HB(time_seq):
  n=len(time_seq[:,1])
  NHB=0.0
  for i in range(n):
    if(time_seq[i,1]<3.50):
      NHB=NHB+1.0
  return NHB/float(n)

Nfiles=len(PW_list)
for i in range(Nfiles):
    a=np.genfromtxt(PW_list[i])
    HB_lifetime=count_HB(a)
    print list_name1[i]," ",list_name2[i]," ",HB_lifetime
