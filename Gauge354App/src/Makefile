TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += Gauge354Support

# Compile and add code to the support library
Gauge354Support_SRCS += xxxRecord.c
Gauge354Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
Gauge354Support_SRCS += dbSubExample.c
Gauge354Support_SRCS += devGauge354Version.c
Gauge354Support_SRCS += Gauge354Hello.c
Gauge354Support_SRCS += initTrace.c

Gauge354Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = Gauge354Version.h
# Macro name
GENVERSIONMACRO = Gauge354VERSION

# Build the IOC application
PROD_IOC = Gauge354

# Gauge354.dbd will be created and installed
DBD += Gauge354.dbd

# Gauge354.dbd will include these files:
Gauge354_DBD += base.dbd
Gauge354_DBD += xxxSupport.dbd
Gauge354_DBD += dbSubExample.dbd
Gauge354_DBD += devGauge354Version.dbd
Gauge354_DBD += Gauge354Hello.dbd
Gauge354_DBD += initTrace.dbd
Gauge354_DBD += asyn.dbd
Gauge354_DBD += drvAsynIPPort.dbd
Gauge354_DBD += drvAsynSerialPort.dbd
Gauge354_DBD += calc.dbd
Gauge354_DBD += stream-scalcout.dbd
Gauge354_DBD += stream.dbd
Gauge354_DBD += as.dbd
Gauge354_DBD += asSupport.dbd
# Gauge354_registerRecordDeviceDriver.cpp derives from Gauge354.dbd
Gauge354_SRCS += Gauge354_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
Gauge354_SRCS_DEFAULT += Gauge354Main.cpp
Gauge354_SRCS_vxWorks += -nil-

# Link in the code from our support library
Gauge354_LIBS += Gauge354Support
Gauge354_LIBS += asyn
Gauge354_LIBS += calc
Gauge354_LIBS += autosave
Gauge354_LIBS += stream
# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into Gauge354Support
    sncExample_SNCFLAGS += +r
    Gauge354_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    Gauge354Support_SRCS += sncExample.stt
    Gauge354Support_LIBS += seq pv
    Gauge354_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    Gauge354_LIBS += qsrv
    Gauge354_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    Gauge354_DBD += PVAServerRegister.dbd
    Gauge354_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
Gauge354_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devGauge354Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
