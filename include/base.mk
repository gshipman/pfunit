SRC_DIR     =$(TOP)/source
TESTS_DIR   =$(TOP)/tests
INCLUDE_DIR =$(TOP)/include
LIB_DIR     =$(TOP)/source
MOD_DIR     =$(TOP)/source

include $(INCLUDE_DIR)/$(F90_VENDOR).mk

F90FLAGS += $I$(INCLUDE_DIR)

ifneq ($(MPI),YES)
  MPIF90=$(F90)
else
  MPIF90 ?=mpif90
endif

ifeq ($(F90_HAS_CPP),YES)
%.o: %.F90
	$(MPIF90) -c $(F90FLAGS) -o $@ $<
else
%.o:%.F90
	@$(CPP) $(CPPFLAGS) $(FPPFLAGS) $< > $*_cpp.F90
	$(F90) -c $(F90FLAGS)  $*_cpp.F90 -o $@
	$(RM) $*_cpp.F90
endif

.PHONY: clean distclean

clean:
	$(RM) *.o *.mod

distclean: clean
	$(RM) *a *.x *~
