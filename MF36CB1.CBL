******************************************************************
      ***                 MF36CB1 : FRONT END PROGRAM                ***
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MF36CB1.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY MF89CP1.
       01 WS-ERROR-FLAG             PIC X(01) VALUE SPACES.
          88 ERROR-FLAG-YES                   VALUE 'Y'.
          88 ERROR-FLAG-NO                    VALUE 'N'.
       PROCEDURE DIVISION.
      ***-----------------------------------------------------------***
      ***  MAIN PROCEDURE                                           ***
      ***-----------------------------------------------------------***
       00000-MAINLINE.
            PERFORM 10000-INITIALIZE.
            PERFORM 20000-SEND-MAP.
            PERFORM 30000-RECEIVE-MAP.
            PERFORM 40000-MAIN-PROCESS.
            PERFORM 50000-EXIT.
      ***-----------------------------------------------------------***
      ***  INITI  PROCEDURE                                         ***
      ***-----------------------------------------------------------***
       10000-INITIALIZE.
           MOVE LOW-VALUES TO MF36BMSI
           MOVE LOW-VALUES TO MF36BMSO.
      ***-----------------------------------------------------------***
      ***  PROCEDURE TO SEND MAP                                    ***
      ***-----------------------------------------------------------***
       20000-SEND-MAP.
             EXEC CICS SEND
                  MAP('MF36BMS')
                  MAPSET('MF36BMS')
                  FROM(MF36BMSO)
                  ERASE
             END-EXEC.
      ***-----------------------------------------------------------***
      ***  PROCEDURE TO RECEIVE  MAP                                ***
      ***-----------------------------------------------------------***
       30000-RECEIVE-MAP.
             EXEC CICS RECEIVE
                  MAP('MF36BMS')
                  MAPSET('MF36BMS')
                  INTO(MF36BMSI)
             END-EXEC.
      ***-----------------------------------------------------------***
      ***  MAIN PROCESSING OF THE PROGRAM                           ***
      ***-----------------------------------------------------------***
       40000-MAIN-PROCESS.
            CALL 'MF36CB2'  USING MF36BMSI
                                  MF36BMSO
                                  WS-ERROR-FLAG
            IF ERROR-FLAG-YES
               CONTINUE
            ELSE
               CALL 'MF36CB3'  USING MF36BMSI
                                     MF36BMSO
            END-IF
            PERFORM 20000-SEND-MAP.
      ***-----------------------------------------------------------***
      ***  END OF THE PROGRAM - END PROCEDURE                       ***
      ***-----------------------------------------------------------***
       50000-EXIT.
             EXEC CICS RETURN
                  TRANSID('MF36')
             END-EXEC.
      ***-----------------------------------------------------------***