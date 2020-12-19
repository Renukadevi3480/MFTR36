   ******************************************************************
      * DCLGEN TABLE(MFTR36.CLAIMS)                                    *
      *        LIBRARY(MFTR36.DCLGEN.COPYLIB(CLAIMS))                  *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        STRUCTURE(CLAIMS)                                       *
      *        APOST                                                   *
      *        LABEL(YES)                                              *
      *        DBCSDELIM(NO)                                           *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE MFTR36.CLAIMS TABLE
           ( CLAIMNUMBER                    INTEGER NOT NULL,
             CLAIMDATE                      DATE,
             PAID                           INTEGER,
             CVALUE                         INTEGER,
             CAUSE                          VARCHAR(255),
             OBSERVATIONS                   VARCHAR(255)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE MFTR36.CLAIMS                      *
      ******************************************************************
       01  CLAIMS.
      *    *************************************************************
           10 CLAIMNUMBER          PIC S9(9) USAGE COMP.
      *    *************************************************************
           10 CLAIMDATE            PIC N(10) USAGE NATIONAL.
      *    *************************************************************
           10 PAID                 PIC S9(9) USAGE COMP.
      *    *************************************************************
           10 CVALUE               PIC S9(9) USAGE COMP.
      *    *************************************************************
           10 CAUSE                PIC N(255) USAGE NATIONAL.
      *    *************************************************************
           10 OBSERVATIONS         PIC N(255) USAGE NATIONAL.
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ICLAIMS.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 6 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 6       *
      ******************************************************************