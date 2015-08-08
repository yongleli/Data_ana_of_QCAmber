load GCN5.init.pdb
# hide the initially loaded representation
hide all;
# set background color to white
bg_color white;


select react_center, (resi 171 & name ce+nz+hz2+hz3+cd+cg+cb) | (resi 179 & name c20+c21+c22+c23+s1+o17+c17+c18+c19+n7+h27)
show sticks, react_center
orient react_center

select background_mol, (resi 29+37+77+79+7430+3659+5288+568 & name o+h1+h2+ca+c+o+n+h)
show sticks, background_mol

select background_mol_pt2, resi 37 & name cb+ce1+ce2+cz+oh+hh+cd1+cd2+cg

how spheres, qwt
set sphere_scale, 0.25, qwt
set_bond stick_color, cyan, name ce+cg+cd+cb+c20+c21+c22+c23+c19+c18+c17 & react_center
set_bond stick_radius, 0.1, background_mol
set_bond stick_radius, 0.1, background_mol_pt2
set dash_width, 6
