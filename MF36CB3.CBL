 ******************************************************************
      ***             MF36CB3 : DATA INTERACTION PROGRAM             ***
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MF36CB3.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CLMNBR                PIC S9(9).
       01 WS-SQLCODE               PIC -9(03).
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
           EXEC SQL
               INCLUDE MF36CP2
           END-EXEC.
       LINKAGE SECTION.
           COPY MF36CP1.
       PROCEDURE DIVISION USING MF36BMSI
                                MF36BMSO.
      ***-----------------------------------------------------------***
      ***  MAIN PROCEDURE                                           ***
      ***-----------------------------------------------------------***
       00000-MAINLINE.
           EVALUATE OPTIONI
             WHEN '1'
               PERFORM 10000-INQUIRY-PARA
             WHEN '2'
               PERFORM 20000-UPDATE-PARA
           END-EVALUATE
           GOBACK.
      ***-----------------------------------------------------------***
      ***  INQUIRY OPTION                                           ***
      ***-----------------------------------------------------------***
       10000-INQUIRY-PARA.
           MOVE CLMNBRI(4:7) TO WS-CLMNBR
           MOVE WS-CLMNBR    TO CLAIMNUMBER OF CLAIMS
            EXEC SQL
                SELECT  CLAIMDATE,
                        PAID,
                        CVALUE,
                        CAUSE,
                        OBSERVATIONS
                INTO   :CLAIMS.CLAIMDATE,
                       :CLAIMS.PAID,
                       :CLAIMS.CVALUE,
                       :CLAIMS.CAUSE,
                       :CLAIMS.OBSERVATIONS
                FROM   MFTR36.CLAIMS
                WHERE  CLAIMNUMBER = :CLAIMS.CLAIMNUMBER
            END-EXEC.
             EVALUATE SQLCODE
               WHEN 0
                 MOVE FUNCTION DISPLAY-OF(CLAIMDATE)    TO CLMDTO
                 MOVE FUNCTION DISPLAY-OF(CAUSE)        TO CAUSEO
                 MOVE FUNCTION DISPLAY-OF(OBSERVATIONS) TO OBSERO
                 MOVE PAID   OF CLAIMS                  TO PAIDO
                 MOVE CVALUE  OF CLAIMS                 TO VALUE1O
               WHEN 100
                 MOVE 'CLAIM NOT FOUND'                 TO MSGO
               WHEN OTHER
                 MOVE SQLCODE                           TO WS-SQLCODE
                 STRING 'SQL ERROR IN FETCH - RC : ' WS-SQLCODE
                 DELIMITED BY SIZE INTO MSGO
                 END-STRING
             END-EVALUATE
             .
      ***-----------------------------------------------------------***
      ***  UPDATE  OPTION                                           ***
      ***-----------------------------------------------------------***
       20000-UPDATE-PARA.
           MOVE CLMNBRI(4:7) TO WS-CLMNBR
           MOVE WS-CLMNBR    TO CLAIMNUMBER OF CLAIMS
           MOVE CLMDTI       TO CLAIMDATE
           MOVE PAIDI        TO PAID   OF CLAIMS
           MOVE VALUE1I      TO CVALUE  OF CLAIMS
           MOVE CAUSEI       TO CAUSE
           MOVE OBSERI       TO OBSERVATIONS
            EXEC SQL
                INSERT  INTO MFTR36.CLAIMS
                       (CLAIMNUMBER,
                        CLAIMDATE,
                        PAID,
                        CVALUE,
                        CAUSE,
                        OBSERVATIONS)
                VALUES (:CLAIMS.CLAIMNUMBER,
                        :CLAIMS.CLAIMDATE,
                        :CLAIMS.PAID,
                        :CLAIMS.CVALUE,
                        :CLAIMS.CAUSE,
                        :CLAIMS.OBSERVATIONS)
            END-EXEC
            EVALUATE SQLCODE
               WHEN 0
                  MOVE 'CLAIM ADDED SUCCESSFULLY' TO MSGO
               WHEN -803
                  MOVE 'DUPLICATE INSERT FAILED'  TO MSGO
               WHEN OTHER
                  MOVE 'SQL ERROR IN INSERT'      TO MSGO
            END-EVALUATE
            .
      ***----------------------------------------------------------
