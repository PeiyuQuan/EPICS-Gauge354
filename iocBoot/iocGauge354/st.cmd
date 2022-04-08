#!../../bin/linux-x86_64/Gauge354

#- You may have to change Gauge354 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/Gauge354.dbd"
Gauge354_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/Gauge354App/Db")
epicsEnvSet ("PREFIX", "SLAC:Gauge354:")
epicsEnvSet ("PORT", "serial1")
epicsEnvSet ("M", "m1:")

drvAsynIPPortConfigure("serial1", "192.168.0.30:4005<192.168.0.30:4005/> COM", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"crtscts","N")
asynSetTraceIOMask("serial1",0,ESCAPE)
asynSetTraceMask("serial1",0,DRIVER|ERROR)

asynSetTraceIOMask("serial1",0,2)
asynSetTraceMask("serial1",0,9)

dbLoadRecords ("${TOP}/Gauge354App/Db/gauge354.db", "P=$(PREFIX), M=$(M), PORT=serial1")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1, PORT=serial1, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:Gauge354:")


cd "${TOP}/iocBoot/${IOC}"
iocInit

