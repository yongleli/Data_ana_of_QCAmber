FC    =  gfortran
EXE   =  rec
OBJS  =  variables.o constants.o checkexistance.o read_prmtop.o read_coord.o calc_ele.o calc_vdw.o main.o
#OBJS  =  constants.o checkexistance.o main.o
MOD   =  variables.mod constants.mod
LIB   =  -lm
OPTION=  -O2 #-xSSSE3

$(EXE):$(OBJS) $(MOD)
        $(FC) -o $@ $(OBJS) $(LIB) $(OPTION)
#$(OBJS): %.o: %.f90
#       $(FC) -c $< $(OPTION)
#$(MOD): %.f90: %.o
#       $(FC) -c $< $(OPTION)
%.o %.mod: %.f90
        $(FC) -c -o $@ $<

clean:
        rm *.o
        rm *.mod
allclean:
        rm *.o
        rm $(EXE)
