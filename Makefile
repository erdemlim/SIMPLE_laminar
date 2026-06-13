# This is the Loci base directory.
LOCI_BASE ?= /lustre/home/t23371/LOCI/Softwares/Loci-4.0-p5/Loci-Linux-x86_64-mpic++-rel-4-0-p5
# List your object files here
OBJS  =  main.o varFileInputs.o geom.o momentum.o rhiechow.o pce.o correction.o convergenceCheck.o wallBC.o farfield.o symmetryBC.o initialValues.o linearSolverFSGS.o linearSolverLSGS.o linearSolverSGS.o plot.o velInlet.o pOutlet.o
# List the name of your compiled program here
TARGET = simple

INCLUDES = -I./include

#############################################################################
# No changes needed below this line

include $(LOCI_BASE)/Loci.conf

default:
	$(MAKE) $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(OBJS) $(LOCAL_LIBS) $(LIBS) $(LDFLAGS)


clean:
	rm -fr $(OBJS) $(TARGET) 

# Junk files that are created while editing and running cases
JUNK = $(wildcard *~) $(wildcard crash_dump.*)  core debug output $(wildcard .schedule*)
# ".cc" files created from .loci files
LOCI_INTERMEDIATE_FILES = $(subst .loci,.cc, $(wildcard *.loci) )

distclean:
	rm -fr $(OBJS) $(TARGET) $(JUNK) $(LOCI_INTERMEDIATE_FILES) $(DEPEND_FILES) 

DEPEND_FILES=$(subst .o,.d,$(OBJS))

#include automatically generated dependencies
-include $(DEPEND_FILES)
