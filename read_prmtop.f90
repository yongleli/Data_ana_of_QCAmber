    subroutine read_prmtop(prmtoporg)
      use variables
      implicit none
      character(len=80),intent(in) :: prmtoporg

      !! Local variables
      character(len=80) :: pline

        open(12,file=prmtoporg)
        do while(.True.)
          read(12,'(A80)',end=100)pline
          !write(*,'(A80)')pline
          if(pline(1:14).eq.'%FLAG POINTERS')then
            read(12,'(A80)')pline
            read(12,'(A80)')pline !! Meaningful line, 1
            read(pline(1:8),'(I8)')natm
            read(pline(9:16),'(I8)')ntypes
            read(12,'(A80)')pline !! Meaningful line, 2
            read(pline(9:16),'(I8)')nres
            allocate(atmname(natm))
            allocate(charge(natm))
            allocate(resname(nres))
            allocate(resid(nres))
            allocate(iac(natm))
            allocate(ico(ntypes*ntypes))
            ncn1=ntypes*(ntypes+1)/2
            allocate(cn1(ncn1))
            ncn2=ntypes*(ntypes+1)/2
            allocate(cn2(ncn2))
          else if(pline(1:15).eq.'FLAG ATOM_NAME') then
            read(12,'(A80)')pline
            read(12,'(20A4)')atmname
          else if(pline(1:12).eq.'%FLAG CHARGE')then
            read(12,'(A80)')pline
            read(12,'(5E16.8)')charge
          else if(pline(1:21).eq.'%FLAG ATOM_TYPE_INDEX') then !! Reading indeces for  vdW.
              read(12,'(A80)')pline
            read(12,'(10I8)')iac
          else if(pline(1:26).eq.'%FLAG NONBONDED_PARM_INDEX') then !! 2nd indeces for vdW.
            read(12,'(a80)')pline
            read(12,'(10I8)')ico
          else if(pline(1:19).eq.'%FLAG RESIDUE_LABEL') then !! RES NAME
            read(12,'(a80)')pline
            read(12,'(20A4)')resname
          else if(pline(1:21).eq.'%FLAG RESIDUE_POINTER') then !! RES POINTER
            read(12,'(a80)')pline
            read(12,'(10I8)')resid
          else if(pline(1:25).eq.'%FLAG LENNARD_JONES_ACOEF') then
            read(12,'(a80)')pline
            read(12,'(5E16.8)')cn1
          else if(pline(1:25).eq.'%FLAG LENNARD_JONES_BCOEF') then
            read(12,'(a80)')pline
            read(12,'(5E16.8)')cn2
          endif
        end do
  100   close(12)
  end subroutine read_prmtop
