module variables
  real(kind=8),allocatable :: coord(:)
  integer :: natm, ntypes, nres
  real(kind=8),allocatable :: charge(:)
  character(len=4),allocatable :: resname(:)
  integer,allocatable :: resid(:)
  integer,allocatable :: iac(:)
  integer,allocatable :: ico(:)
  integer :: ncn1,ncn2
  real(kind=8),allocatable :: cn1(:), cn2(:) !! Lennard-Jones A and B coefficients
  character(len=4),allocatable :: atmname(:)
  integer,parameter :: Nqm=30
  real(kind=8) :: espcharge(Nqm)
end module variables
