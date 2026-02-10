cd "/epics/ioc"

epicsEnvSet EPICS_TZ GMT0BST

dbLoadDatabase "dbd/TS99I-CS-IOC-03.dbd"
ioc_registerRecordDeviceDriver(pdbbase)

# Create SSH Port (PortName, IPAddress, Username, Password, Priority, DisableAutoConnect, noProcessEos)
drvAsynPowerPMACPortConfigure("SSHP", "172.23.243.14", "root", "deltatau", "0", "0", "0")

# Configure Model 3 Controller Driver (ControlerPort, LowLevelDriverPort, Address, Axes, MovingPoll, IdlePoll)
pmacCreateController("pwbrick", "SSHP", 0, 4, 100, 1000)
# Configure Model 3 Axes Driver (Controler Port, Axis Count)
pmacCreateAxes("pwbrick", 4)

asSetFilename '/dls_sw/prod/R3.14.12.7/support/pvlogging/1-4/data/access.acf'

dbLoadRecords '/epics/runtime/TS99I-CS-IOC-03_expanded.db'
dbLoadRecords '/epics/runtime/TS99I-CS-IOC-03.db'
iocInit

# Extra post-init IOC commands
dbpf TS99I-MO-SERVC-01:MODESEL 2
