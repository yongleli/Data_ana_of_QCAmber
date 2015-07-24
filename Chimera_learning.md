color by atomic RMSD
1.	Prepare the RMSD. To calculate:
rmsd #0:xxx #1:yyy
Then, prepare a data file. (Chimera search: Define Attribute)
The separators of each data must be TAB rather than BLANK.
defattr "/Users/yongleli1/Research_Data/GCN5/rmsd_4p.dat"

www.cgl.ucsf.edu/pipermail/chimera-users/2012-April/007400.html

The data file should contain the header lines. The data lines initial as Tab, and also separated as Tab. To prepare the data using awk, just use command like this:
awk ‘{printf”\t%s\t%g\n”}’ xxx.dat > xxx.att
Here, the \t can output the tab blank, and s denotes string, and g denotes the float.

Set boulder line:
Tools→ Viewing Controls→ Effects, in Silhouettes.
Set transparent ribbon:
transparency 50,r
Select serial number of atom
select @/serialNumber=xxx

chimera –nogui (Do not show the GUI when run scripts.)

Select multiple atoms by serial number:
select @/serialNumber>xxx & @/serialNumber<yyy

Adjust bond radius.
setattr b radius 0.5 :12.a

Predict the side chain:
swapaa
Dunbrack’s group

Adjust sphere radius
setattr a radius 0.5 :201@POL

Displaying b-factor as ribbon thickness
Tools→depiction→Render by attribute
residues
attribute: average→bfactor
Worms→ smooth

Start without gui:
chimera –nogui

Smooth surface
setattr  s density 10
setattr s probeRadius 1.5

Change the guess of bonds:
Tools → general tools → pseudobond options

Two array types in Python:
1.	a[i,j]
2.	a[i][j]

In windows, the attribute file should be in Windows returning convention:
awk ‘{printf”%s %s\r\n”,$1,$2}’ linux.dat > windows.dat
Then, put the file in C:\ 
Now, one can use command: 
defattr “/windows.dat”
Everything should be OK now.

Pocket surface:
sop zone #0 :ACO 5.0 max 1
Show both backbone atoms and ribbons:
ribbackbone #4:1790

Change the ribbon thickness:
ribscale "all 0.1" #3

Change the radius of atoms:
setattr a radius 0.8 :79,29,77,37 ## a for atom.
