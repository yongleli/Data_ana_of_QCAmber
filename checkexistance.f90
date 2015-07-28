subroutine file_exist(filename, istatus)
!! Check the existance of file.
implicit none
character(len=80),intent(in) :: filename
integer,intent(inout) :: istatus
logical :: iffile

iffile=.FALSE.

INQUIRE(FILE = filename, exist=iffile)
if(trim(filename)=='' .or. .not. iffile ) then
  print *, "Where is the file?"
  istatus=1
end if
!!
end subroutine file_exist
