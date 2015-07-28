    !subroutine read_coord(coordfile,natm, coord,filetype)
    subroutine read_coord(coordfile,filetype,istatus)
      use variables
      implicit none
      character(len=80),intent(in) :: coordfile
      character(len=80),intent(in) :: filetype
      integer :: Natm_rst, triatm
      logical :: ifopen
      character(len=10) :: tmpline
      real(kind=8) :: box(3) !! Not used in program, only read it here for cycle.
      integer,intent(out) :: istatus
      real(kind=8),parameter :: Cele=dsqrt(332.05d0)
      istatus=0
      select case(trim(filetype))
       case("RST")
        inquire(file=coordfile,OPENED=ifopen)
        if(.not.ifopen) then
         open(10,file=coordfile)
        end if
         read(10,*,end=199)
         read(10,*,end=199) Natm_rst
         print *, Natm_rst
         if(Natm_rst/=natm) then
           print *, "Please check your number of atoms!!"
           stop
         end if
         read(10,'(6F12.7)',end=199) coord
         return
         199 close(10)
         istatus=1
       case("rst")
        inquire(file=coordfile,OPENED=ifopen)
        if(.not.ifopen) then
         open(10,file=coordfile)
        end if
         read(10,*,end=299)
         read(10,*,end=299) Natm_rst
         print *, Natm_rst
         if(Natm_rst/=natm) then
           print *, "Please check your number of atoms!!"
           stop
         end if
!         triatm=3*natm
!         allocate(coord(triatm))
         read(10,'(6F12.7)',end=299) coord
         return
         299 close(10)
         istatus=1
       case("CRD")
         inquire(file=coordfile,OPENED=ifopen)
         if(.not.ifopen) then
           open(10,file=coordfile)
           read(10,*,end=999) tmpline !! Only the 1st line contains nonsense!
!           triatm=3*natm
!           allocate(coord(triatm))
           open(20,file='esp_charge.dat')
         end if
         coord=0.0d0
         read(10,'(10F8.3)',end=999) coord
         read(10,*,end=999) box
         read(20,*,end=999) espcharge
         espcharge=espcharge*Cele
         read(20,*)
         !print *, box
         return
         999 close(10)
         close(20)
         istatus=1
       case("COORD")
         open(10,file=coordfile)
         coord=0.0d0
         read(10,*) coord
         close(10)
         open(11,file='esp_charge.dat')
         read(11,*) espcharge
         close(11)
       case default
         print *, "No type..."
         stop
      end select
      !close(10)
    end subroutine
