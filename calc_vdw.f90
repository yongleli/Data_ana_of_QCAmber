subroutine calc_vdw(res1, res2, Evdw,istatus)
!! Only calculate 1 pair: res1 and res2
      use variables
      implicit none
      integer,intent(in) :: res1, res2
      real(kind=8),intent(out) :: Evdw
      integer,intent(out):: istatus
      integer :: res_end1, res_end2, i, j, k
      real(kind=8) :: rij
      integer :: index_ij

      istatus=0

      if(res1+1<=nres) then
        res_end1=resid(res1+1)-1
      else
        res_end1=nres
      end if
      if (res1==179) then !! For QM/MM.
        res_end1=3058
      end if              !! End for QM/MM.
      if (res1==171) then
        resid(171)=2849
        res_end1=2865
      end if

      if(res2+1<=nres) then
        res_end2=resid(res2+1)-1
      else
        res_end2=nres
      end if
      if (res2==179) then !! For QM/MM.
        res_end2=3058
      end if              !! End for QM/MM.
      if (res2==171) then
        resid(171)=2849
        res_end2=2865
      end if

      Evdw=0.0d0
      do i=resid(res1),res_end1
        if (res1==171 .and. i==2850) cycle
        do j=resid(res2),res_end2
          if (res2==171 .and. j==2850) cycle
          !if(res_end1==3060 .or. res_end2==3060) then
          !  print *, i, j
          !end if
          rij=0.0d0
          do k=1,3
            rij=rij+(coord((i-1)*3+k)-coord((j-1)*3+k))**2
          end do
          rij=dsqrt(rij)
          index_ij=ico(ntypes*(iac(i)-1)+iac(j))
          !!print '(2I5,F12.6,2ES16.6,F12.6)', i, j, rij, cn1(index_ij), cn2(index_ij), cn1(index_ij)/rij**12-cn2(index_ij)/rij**6
          Evdw=Evdw+(cn1(index_ij)/rij**12-cn2(index_ij)/rij**6)
        end do
      end do
      !print *, Evdw, "  Evdw"
    end subroutine calc_vdw
