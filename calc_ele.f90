    !subroutine calc_ele(natm,nres,res1, res2, Eele,resid,coord,charge)
    subroutine calc_ele(res1, res2, Eele)
!! Only calculate 1 pair: res1 and res2
      use variables
      implicit none
      integer,intent(in) :: res1, res2
      real(kind=8),intent(out) :: Eele

      integer :: res_end1, res_end2, i, j, k
      real(kind=8) :: rij

      if(res1+1<=nres) then
        res_end1=resid(res1+1)-1
      else
        res_end1=nres
      end if
      if (res1==179) then
        res_end1=3058
      end if
      if (res1==171) then
        resid(171)=2849
        res_end1=2865
      end if
      if(res2+1<=nres) then
        res_end2=resid(res2+1)-1
      else
        res_end2=nres
      end if
      if (res2==179) then
        res_end2=3058
      end if
      if (res2==171) then
        resid(171)=2849
        res_end2=2865
      end if
      Eele=0.0d0
      do i=resid(res1),res_end1
        if (res1==171 .and. i==2850) cycle
        do j=resid(res2),res_end2
          if(res2==171 .and. j==2850) cycle
          rij=0.0d0
          do k=1,3
            rij=rij+(coord((i-1)*3+k)-coord((j-1)*3+k))**2
          end do
          rij=dsqrt(rij)
          !print '(2I5,1X,4F12.6)', i, j, rij, charge(i), charge(j), charge(i)*charge(j)/rij
          Eele=Eele+charge(i)*charge(j)/rij
        end do
      end do
      !print *, Eele, "  Eele"
    end subroutine calc_ele
