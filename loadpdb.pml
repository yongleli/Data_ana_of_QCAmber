### Load pdb into PyMol to further plot.
### 
load GCN5.init.pdb
# hide the initially loaded representation
hide all;
# set background color to white
bg_color white;


select react_center, (resi 171 & name ce+nz+hz2+hz3+cd+cg+cb) | (resi 179 & name c20+c21+c22+c23+s1+o17+c19+n7+h27)
show sticks, react_center
set_bond stick_radius, 0.1, react_center
orient react_center

select background_mol, (resi 29+37+77+79+7430+3659+5288+568 & name o+h1+h2+ca+c+o+n+h)
show sticks, background_mol

select background_mol_pt2, resi 37 & name cb+ce1+ce2+cz+oh+hh+cd1+cd2+cg

select qwt, resn qwt

show spheres, qwt
show sticks, qwt
show sticks, background_mol_pt2
set_bond stick_radius, 0.2, qwt
set sphere_scale, 0.25, qwt
color cyan, name c19+c20+c21+c22+c23+ce+cg+cd+cb & react_center
set_bond stick_radius, 0.1, background_mol
set_bond stick_radius, 0.1, background_mol_pt2

set dash_width, 6
dist NZ_C, react_center & name nz, react_center & name c22
dist HZ3_O1, react_center & name hz3, qwt & name o1
dist H1_O17, react_center & name o17, qwt & name h1
hide labels
set dash_color, lime
