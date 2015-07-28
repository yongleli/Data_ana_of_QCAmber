module constants
  implicit none
  real(kind=8),parameter :: Cele=dsqrt(332.05d0)
  interface utils
    subroutine read_prmtop(prmtoporg)
      use variables
      implicit none
      character(len=80),intent(in) :: prmtoporg
      !! Local variables
      character(len=80) :: pline

    end subroutine read_prmtop

    subroutine read_coord(coordfile,filetype,istatus)
      use variables
      implicit none
      character(len=80),intent(in) :: coordfile
      character(len=80),intent(in) :: filetype
      !character(len=80),intent(in),optional :: chgfile

      integer :: Natm_rst, triatm
      logical :: ifopen
      character(len=10) :: tmpline
      real(kind=8) :: box(3) !! Not used in program, only read it here for cycle.
      integer,intent(out) :: istatus
    end subroutine read_coord

    subroutine calc_ele(res1, res2, Eele)
      use variables
      implicit none
      integer,intent(in) :: res1, res2
      real(kind=8),intent(out) :: Eele

      integer :: res_end1, res_end2, i, j, k
      real(kind=8) :: rij
    end subroutine calc_ele
    subroutine calc_vdw(res1, res2, Evdw,istatus)
      use variables
      implicit none
      integer,intent(in) :: res1, res2
      real(kind=8),intent(out) :: Evdw
      integer,intent(out):: istatus
      integer :: res_end1, res_end2, i, j, k
      real(kind=8) :: rij
      integer :: index_ij
    end subroutine calc_vdw
  end interface utils
end module constants
