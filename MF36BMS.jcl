//MFTR361 JOB ,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(,4),REGION=144M,COND=(16,LT)
//*
//STP0000 EXEC PROC=ELAXFBMS
//ASMMAP.SYSPUNCH DD DISP=SHR,
//        DSN=MFTR36.BMSOBJS.OBJ(MF36BMS)
//ASMMAP.SYSIN DD DISP=SHR,
//        DSN=MFTR36.SOURCE.BMS(MF36BMS)
//*
//ASMDSECT.SYSPUNCH DD DISP=OLD,
//        DSN=MFTR36.BMS.DSCTLIB(MF36BMS)
//ASMMAP.SYSLIN DD DISP=SHR,
//        DSN=MFTR36.BMSOBJS.OBJ(MF36BMS)
//ASMDSECT.SYSIN DD DISP=SHR,
//        DSN=MFTR36.SOURCE.BMS(MF36BMS)
//*
//LKED EXEC PROC=ELAXFLNK
//LINK.OBJ0000 DD DISP=SHR,
//        DSN=MFTR36.BMSOBJS.OBJ(MF36BMS)
//LINK.SYSLIN DD *
     INCLUDE OBJ0000
/*
//LINK.SYSLMOD   DD  DISP=SHR,
//        DSN=MFTR36.ZDEVOPS.LOADLIB(MF36BMS)
//*
//******* ADDITIONAL JCL FOR LINK HERE ******
//