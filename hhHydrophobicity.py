import numpy as np
import sys,os
import fileinput

### Build the dictionary for polarity values.
f0='polarity.dict.dat'
hhpol={}
i=0
for lines in fileinput.input(f0):
  if lines[0:1]!="#":
    elements = lines.split()
    aname=elements[0]
    value=float(elements[3])
    hhpol[aname]=value

#print hhpol

## Read in the sequence. The sequence is from the PDB file.
##
f1=sys.argv[1]
seq=[]

for lines in fileinput.input(f1):
  #print lines
  data=lines.split()
  n=len(data)
  for i in range(n):
    seq.append(data[i])

## Write the attribution file.
print "attribute: percentExposed"
print "match mode: 1-to-1"
print "recipient: residues"

Nseq=len(seq)
iInit=48
for i in range(Nseq):
  print "\t:"+str(i+iInit)+"\t", hhpol[seq[i]] ## Here the PDB is initial from 48...
