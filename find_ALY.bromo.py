import subprocess
def torsion(coord, n1, n2, n3, n4):
  import numpy as np
  from math import atan,sqrt,acos
  PI=4.0*atan(1.0)
  Lx = (coord[(n2)*3+1]-coord[(n1)*3+1])*(coord[(n3)*3+2]-coord[(n2)*3+2]) \
     - (coord[(n2)*3+2]-coord[(n1)*3+2])*(coord[(n3)*3+1]-coord[(n2)*3+1])
  Ly = (coord[(n2)*3+2]-coord[(n1)*3+2])*(coord[(n3)*3+0]-coord[(n2)*3+0]) \
     - (coord[(n2)*3+0]-coord[(n1)*3+0])*(coord[(n3)*3+2]-coord[(n2)*3+2])
  Lz = (coord[(n2)*3+0]-coord[(n1)*3+0])*(coord[(n3)*3+1]-coord[(n2)*3+1]) \
     - (coord[(n2)*3+1]-coord[(n1)*3+1])*(coord[(n3)*3+0]-coord[(n2)*3+0])

  Rx = (coord[(n4)*3+1]-coord[(n3)*3+1])*(coord[(n2)*3+2]-coord[(n3)*3+2]) \
     - (coord[(n4)*3+2]-coord[(n3)*3+2])*(coord[(n2)*3+1]-coord[(n3)*3+1])
  Ry = (coord[(n4)*3+2]-coord[(n3)*3+2])*(coord[(n2)*3+0]-coord[(n3)*3+0]) \
     - (coord[(n4)*3+0]-coord[(n3)*3+0])*(coord[(n2)*3+2]-coord[(n3)*3+2])
  Rz = (coord[(n4)*3+0]-coord[(n3)*3+0])*(coord[(n2)*3+1]-coord[(n3)*3+1]) \
     - (coord[(n4)*3+1]-coord[(n3)*3+1])*(coord[(n2)*3+0]-coord[(n3)*3+0])

  Lnorm = sqrt(Lx*Lx + Ly*Ly + Lz*Lz)
  Rnorm = sqrt(Rx*Rx + Ry*Ry + Rz*Rz)

  Sx = (Ly*Rz) - (Lz*Ry)
  Sy = (Lz*Rx) - (Lx*Rz)
  Sz = (Lx*Ry) - (Ly*Rx)

  angle = (Lx*Rx + Ly*Ry + Lz*Rz) / (Lnorm * Rnorm)

  if ( angle > 1.0 ) :
    angle = 1.0
  if ( angle < -1.0 ) :
    angle = -1.0
  angle = acos( angle )

  if ( (Sx * (coord[(n3)*3+0]-coord[(n2)*3+0]) + \
        Sy * (coord[(n3)*3+1]-coord[(n2)*3+1]) + \
        Sz * (coord[(n3)*3+2]-coord[(n2)*3+2])) < 0 ):
    angle = -angle

  torsion_angle=angle*180.0/PI
  return torsion_angle


import numpy as np
import sys,os

fname=sys.argv[1] ## Raw data!

f1=open(fname,'r')
a=[]
for lines in f1:
  a.append(lines[0:8])

pdb_file=np.unique(a).tolist()

Nfiles=len(pdb_file)
k=0
j=0
for i in range(Nfiles):
  cmd="awk '($1~/ATOM/ || $1~/HETATM/) && $4~/ALY$/ && ($3~/^OH$/ || $3~/^CH$/ || $3~/^NZ$/ || $3~/^CE$/ )\
{print}'  "+pdb_file[i]
  p=subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  coord=[]
  for line in p.stdout.readlines():
    #print line, ## Test only.
    data=line.split()
    ndata=len(data)
    if ndata>8:
      coord.append(float(data[6]))
      coord.append(float(data[7]))
      coord.append(float(data[8]))
      ## print coord[j*3+0], coord[j*3+1], coord[j*3+2]
      j=j+1
      if(j%4==0):
        ## print "END"
        ## Finish reading a whole residue.
        theta=torsion(coord, 0,1,2,3) ## OH, CH, NZ, CE
        if theta<-60 or theta>60:
            print k, theta, pdb_file[i]
        else:
            print k, theta
        k=k+1
        coord=[]
        j=0
  retval = p.wait()
  
