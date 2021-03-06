# How to calculate vdW parameters in AMBER

%FLAG ATOM_TYPE_INDEX
%FORMAT(1OI8)  (IAC(i), i=1,NATOM)
  IAC    : index for the atom types involved in Lennard Jones (6-12) interactions.  See ICO below.

%FLAG NUMBER_EXCLUDED_ATOMS
%FORMAT(10I8)  (NUMEX(i), i=1,NATOM)
  NUMEX  : total number of excluded atoms for atom "i".  Also called IBLO. See NATEX below.

%FLAG NONBONDED_PARM_INDEX
%FORMAT(10I8)  (ICO(i), i=1,NTYPES*NTYPES)
  ICO    : provides the index to the nonbon parameter
           arrays CN1, CN2 and ASOL, BSOL.  All possible 6-12 or 10-12 atoms type interactions are represented. NOTE: A particular atom type can have either a 10-12 or a 6-12 interaction, but not both.  The index is calculated as follows:
             index = ICO(NTYPES*(IAC(i)-1)+IAC(j))
           If index is positive, this is an index into the 6-12 parameter arrays (CN1 and CN2) otherwise it  an index into the 10-12 parameter arrays (ASOL and BSOL).


%FLAG LENNARD_JONES_ACOEF
%FORMAT(5E16.8)  (CN1(i), i=1,NTYPES*(NTYPES+1)/2)
  CN1  : Lennard Jones r**12 terms for all possible atom type interactions, indexed by ICO and IAC; for atom i and j where i < j, the index into this array is as follows (assuming the value of ICO(index) is positive):
         CN1(ICO(NTYPES*(IAC(i)-1)+IAC(j))).

%FLAG LENNARD_JONES_BCOEF
%FORMAT(5E16.8)  (CN2(i), i=1,NTYPES*(NTYPES+1)/2)
  CN2  : Lennard Jones r**6 terms for all possible
         atom type interactions.  Indexed like CN1 above.


NOTE: the atom numbers in the following arrays that describe bonds, angles, and dihedrals are coordinate array indexes for runtime speed. The true atom number equals the absolute value of the number divided by three, plus one. In the case of the dihedrals, if the fourth atom is negative, this implies that the dihedral is an improper. If the third atom is negative, this implies that the end group interations are to be ignored. End group interactions are ignored, for example, in dihedrals of various ring systems (to prevent double counting of 1-4 interactions) and in multiterm dihedrals.

Evdw = A_ij / R_ij^12 - B_ij / R_ij^6
