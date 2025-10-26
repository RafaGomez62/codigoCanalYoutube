      *  OBJETIVO      : COMPARATIVA PGM COBOL AS400 VS MAINFRAME
      *  FECHA         : 25/10/2025
      *  AUTOR         : RGO
      *----------------------------------------------------------------
      *PROCESS QUOTE.
       IDENTIFICATION DIVISION.
      *---------------------------------------------------------------*
       PROGRAM-ID.                COBOLCA.
       AUTHOR.                    RGO.
       INSTALLATION.
       DATE-WRITTEN.              25/10/2025.
       SECURITY.                  COMPARATIVA PGM COBOL AS400
                                  VS MAINFRAME.
      *---------------------------------------------------------------*
       ENVIRONMENT DIVISION.
      *---------------------------------------------------------------*
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.           IBM-AS400.
       OBJECT-COMPUTER.           IBM-AS400.
       SPECIAL-NAMES.             DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.

      *----------------------------------------------------------------
       WORKING-STORAGE SECTION.
      *----------------------------------------------------------------

       01 W-CANTIDAD                PIC S9(09) COMP-5.

           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.

      *================================================================

      *----------------------------------------------------------------
       PROCEDURE DIVISION.
      *----------------------------------------------------------------

       INICIO.

           PERFORM INIC-PROCESO        THRU F-INIC-PROCESO

           PERFORM PROCESO             THRU F-PROCESO

           PERFORM FIN-PROCESO         THRU F-FIN-PROCESO
           .
       F-INICIO.

      *----------------------------------------------------------------
      * CONFIGURACIONES INICIALES PARA EL PROCESO
      *----------------------------------------------------------------
       INIC-PROCESO.

      *    PERFORM CONFIG-COMMIT-SQL   THRU F-CONFIG-COMMIT-SQL
      *    EXEC SQL
      *        SET OPTION COMMIT= *NONE
      *    END-EXEC

           .
       F-INIC-PROCESO.
           EXIT.

      *----------------------------------------------------------------
      * PROCESO DE GENERACIÛN DE INFORME ONP POR PERÌODO PARA SUCURSAL
      *----------------------------------------------------------------
       PROCESO.

           EXEC SQL
               SELECT COUNT(*)
                 INTO :W-CANTIDAD
                 FROM BANCO.CLIENTES
           END-EXEC

           IF SQLCODE NOT = ZEROES
              DISPLAY 'ERROR EN EL SQL'
           ELSE
              DISPLAY 'CANTIDAD DE REGISTROS : '  W-CANTIDAD
           END-IF
           .
       F-PROCESO.
           EXIT.

      *----------------------------------------------------------------
      * PASOS DE CIERRE NECESARIOS Y FIN DE PROCESO
      *----------------------------------------------------------------
       FIN-PROCESO.

           GOBACK
           .
       F-FIN-PROCESO.
           EXIT.

      *----------------------------------------------------------------
      * CONFIGURACIÛN INICIAL DEL COMMIT
      *----------------------------------------------------------------
      *CONFIG-COMMIT-SQL.
      *
      *    EXEC SQL
      *        SET OPTION COMMIT= *NONE
      *    END-EXEC
      *    .
      *F-CONFIG-COMMIT-SQL.
      *    EXIT.
