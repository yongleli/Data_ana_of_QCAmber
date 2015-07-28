program main
use variables
use constants
implicit none

character(len=80) :: prmtoporg, coordfile, file_pep, chgfile
character(len=80) :: filetype
real(kind=8) :: Eele, Evdw, Eres

integer :: istatus
integer :: i, j, ii, jj
integer :: ipep_begin, ipep_last, iprot_first,iprot_last
integer,parameter :: Nframes=391 !! Please note this variable, it's different by case!
!integer,parameter :: Nframes=1 !! For test only
real(kind=8),allocatable :: S(:), ave_ene(:), std_ene(:),S2(:)
real(kind=8) :: rc(3), rc_tot, Etot
integer :: rc_test
external :: rc_test
!integer :: ifrun

write(*,*) "Welcome to the calculation of SIE."
write(*,*) "This is the first part, calculate the E_QM_MM for a single part, R or TS."
write(*,*) "Don't forget to input the number of frames."
write(*,*) "And the charge file: esp_charge.dat must be exactly corresponding to the traj file."
write(*,*) "And the criteria in rc_test must be changed for different stages."

istatus=0
natm=0
ntypes=0
nres=0
ncn1=0
ncn2=0
filetype=''
prmtoporg=''
coordfile=''
call getarg(1,prmtoporg)
call getarg(2,coordfile)
call getarg(3,filetype)
call getarg(4,file_pep)
!call getarg(5,chgfile)

call file_exist(prmtoporg, istatus)
call file_exist(coordfile, istatus)
call file_exist(file_pep, istatus)

if(istatus==0) then
  open(15,file= file_pep)
  read(15,*) ipep_begin, ipep_last, iprot_first,iprot_last
  call read_prmtop(prmtoporg)

  allocate(coord(natm*3)) !!
  do j=1, Nframes !! Main loop for total frames.
    istatus=0
    call read_coord(coordfile, filetype,istatus)
!!  For QM/MM ESP charge!
    resid(179)=3048
    !print *, atmname
    do ii=17,27
      charge(3048-17+ii) = espcharge(ii)
      !print *, 3048-17+ii, atmname(3048-17+ii), charge(3048-17+ii)/Cele
    end do
    charge(3059) = 0.0d0
    charge(3060) = 0.0d0
    charge(3061) = 0.0d0
    resid(180)=3059
!!   H3-K14 part.
    charge(2847) = 0.0d0
    charge(2848) = 0.0d0
    charge(2849) = espcharge(1)
    charge(2850) = 0.0d0
    do ii=2, 16
      charge(2849+ii) = espcharge(ii)
      !print *, 2849+ii, atmname(2849+ii), charge(2849+ii)/Cele
    end do
    charge(2866) = 0.0d0
    charge(2867) = 0.0d0
!!   QWT part.
    do ii=28,30
      charge(3080-28+ii) = espcharge(ii)
      !print *, 3080-28+ii, atmname(3080-28+ii), charge(3080-28+ii)/Cele
    end do
!!
    if(istatus/=0) stop
    Eres=0.0d0
    rc=0.0d0
    Etot=0.0
    if (rc_test()==1) then
    do ii=iprot_first,iprot_last
      Eres=0.0d0
      i=179
      Eele=0.0d0
      Evdw=0.0d0
      call calc_ele(i, ii, Eele)
      call calc_vdw(i, ii, Evdw,istatus)
      !print *, Eele, Evdw
      Eres=Eres+Eele+Evdw !! For Ac-CoA part
      i=171
      Eele=0.0d0
      Evdw=0.0d0
      call calc_ele(i,ii,Eele)
      call calc_vdw(i,ii,Evdw,istatus)
      !print *, Eele, Evdw
      Eres=Eres+Eele+Evdw !! For H3-K14 part
      i=190
      Eele=0.0d0
      Evdw=0.0d0
      call calc_ele(i,ii,Eele)
      call calc_vdw(i,ii,Evdw,istatus)
      !print *, Eele, Evdw
      Eres=Eres+Eele+Evdw !! For QWT part
      write(*,'(2I8,E16.8,2X,A4)') i,ii, Eres, resname(ii)
      Etot=Etot+Eres
    end do
    write(*,*) j, Etot, " Etot"
    end if
  end do !! End of the loop for frames.
!! End of the program.
  deallocate(charge)
  deallocate(iac)
  deallocate(ico)
  deallocate(cn1)
  deallocate(cn2)
  deallocate(coord)
  deallocate(atmname)
  deallocate(resname)
  deallocate(resid)

else
  print *, "There must be something wrong with the input file."
end if

end program main
function r12(i, j)
use variables
implicit none
integer,intent(in) :: i, j
integer :: k
real(kind=8) :: r12
r12=0.0d0
do k=1,3
  r12=r12+(coord((i-1)*3+k)-coord((j-1)*3+k))**2
end do
r12=dsqrt(r12)
end function r12

function rc_test()
use variables
implicit none
integer :: rc_test
real(kind=8) :: r12
external :: r12
real(kind=8) :: r1, r2, r3, rc
rc_test=0
r1=r12(2865,3080)
r2=r12(2863,3051)
r3=r12(3081,3052)
rc=r1+r2+r3
if(rc<=8.55.and.rc>=8.45) rc_test=1
end function rc_test
