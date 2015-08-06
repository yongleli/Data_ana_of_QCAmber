function angle(n1, n2, n3)
!! Copied from cpptraj code, and changed to Fortran format.
use variables
implicit none
integer,intent(in) :: n1, n2, n3
real(kind=8) :: xij, yij, zij
real(kind=8) :: xkj, ykj, zkj
real(kind=8) :: rij, rkj
real(kind=8),parameter :: SMALL=1.0d-6
real(kind=8) :: angle
real(kind=8) :: PI
PI=4.0d0*datan(1.0d0)
  angle=0.0d0
  xij = coord((n1-1)*3+1) - coord((n2-1)*3+1)
  yij = coord((n1-1)*3+2) - coord((n2-1)*3+2)
  zij = coord((n1-1)*3+3) - coord((n2-1)*3+3)

  xkj = coord((n3-1)*3+1) - coord((n2-1)*3+1)
  ykj = coord((n3-1)*3+2) - coord((n2-1)*3+2)
  zkj = coord((n3-1)*3+3) - coord((n2-1)*3+3)

  rij = xij*xij + yij*yij + zij*zij
  rkj = xkj*xkj + ykj*ykj + zkj*zkj

  if (rij > SMALL .and. rkj > SMALL) then
    angle = (xij*xkj + yij*ykj + zij*zkj) / dsqrt(rij*rkj)
    if (angle > 1.0) then
      angle = 1.0d0
    else if (angle < -1.0) then
      angle = -1.0d0
    end if
    angle = dacos(angle)
  else
    angle = 0.0d0
  end if
  angle=angle*180.0d0/PI

end function angle

function r12(i, j)
!! Calculate the distance between two atoms.
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

function torsion(n1, n2, n3, n4)
!! Copied from cpptraj code, and changed to Fortran format.

use variables
implicit none
integer,intent(in) :: n1, n2, n3, n4
real(kind=8) :: torsion
real(kind=8) :: Lx, Ly, Lz
real(kind=8) :: Rx, Ry, Rz
real(kind=8) :: Lnorm, Rnorm
real(kind=8) :: Sx, Sy, Sz
real(kind=8) :: angle
real(kind=8) :: PI
PI=4.0d0*datan(1.0d0)
  Lx = (coord((n2-1)*3+2)-coord((n1-1)*3+2))*(coord((n3-1)*3+3)-coord((n2-1)*3+3)) &
&    - (coord((n2-1)*3+3)-coord((n1-1)*3+3))*(coord((n3-1)*3+2)-coord((n2-1)*3+2))
  Ly = (coord((n2-1)*3+3)-coord((n1-1)*3+3))*(coord((n3-1)*3+1)-coord((n2-1)*3+1)) &
&    - (coord((n2-1)*3+1)-coord((n1-1)*3+1))*(coord((n3-1)*3+3)-coord((n2-1)*3+3))
  Lz = (coord((n2-1)*3+1)-coord((n1-1)*3+1))*(coord((n3-1)*3+2)-coord((n2-1)*3+2)) &
&    - (coord((n2-1)*3+2)-coord((n1-1)*3+2))*(coord((n3-1)*3+1)-coord((n2-1)*3+1))

  Rx = (coord((n4-1)*3+2)-coord((n3-1)*3+2))*(coord((n2-1)*3+3)-coord((n3-1)*3+3)) &
&    - (coord((n4-1)*3+3)-coord((n3-1)*3+3))*(coord((n2-1)*3+2)-coord((n3-1)*3+2))
  Ry = (coord((n4-1)*3+3)-coord((n3-1)*3+3))*(coord((n2-1)*3+1)-coord((n3-1)*3+1)) &
&    - (coord((n4-1)*3+1)-coord((n3-1)*3+1))*(coord((n2-1)*3+3)-coord((n3-1)*3+3))
  Rz = (coord((n4-1)*3+1)-coord((n3-1)*3+1))*(coord((n2-1)*3+2)-coord((n3-1)*3+2)) &
&    - (coord((n4-1)*3+2)-coord((n3-1)*3+2))*(coord((n2-1)*3+1)-coord((n3-1)*3+1))

  Lnorm = dsqrt(Lx*Lx + Ly*Ly + Lz*Lz)
  Rnorm = dsqrt(Rx*Rx + Ry*Ry + Rz*Rz)

  Sx = (Ly*Rz) - (Lz*Ry)
  Sy = (Lz*Rx) - (Lx*Rz)
  Sz = (Lx*Ry) - (Ly*Rx)

  angle = (Lx*Rx + Ly*Ry + Lz*Rz) / (Lnorm * Rnorm)

  if ( angle > 1.0 ) angle = 1.0
  if ( angle < -1.0 ) angle = -1.0

  angle = dacos( angle )

  if ( (Sx * (coord((n3-1)*3+1)-coord((n2-1)*3+1)) + &
&       Sy * (coord((n3-1)*3+2)-coord((n2-1)*3+2)) + &
&       Sz * (coord((n3-1)*3+3)-coord((n2-1)*3+3))) < 0 ) then
    angle = -angle
  end if

  torsion=angle*180.0d0/PI

end function torsion
