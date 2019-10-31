;
;
@laser
@logtick
;*********************************************************************
;  MAIN PROGRAM
;*********************************************************************
;  Plot the photoelectron source function or the photoelectron flux.
;/////////////////////////////////////////////////////////////////////
; 
   !TYPE = 12
   ANS   = ' '
   FILES = ['pesource.dat','peflux.dat']
;
   SELECT_FILE,FILES,CHO
   FILENAME = FILES(CHO)
;
   CASE CHO OF
      0: BEGIN    
           TITL = 'Photoelectron Source Function'+ $
                  ' (cm!u-3!n s!u-1!n eV!u-1!n)'
         END
      1: BEGIN
           TITL = 'Photoelectron Flux (cm!u-2!n s!u-1!n eV!u-1!n)'
         END
   ENDCASE
;
   READPEX,FILENAME,NEGRID,EGRID,NALT,ALT,PEX
;
   !X.RANGE = [0,800]
   !X.TICKS = 8
   !X.MINOR = 2
   !XTITLE = 'Energy (eV)'
   !YTITLE = TITL
;
   ZTOP  = ALT(0)
   ZBOT  = ALT(NALT-1)
   INDX  = 0
   ZPLOT = 0.0
;
   DONE = 0
   WHILE (DONE EQ 0) DO BEGIN
      PRINT,''
      PRINT,' The altitude range is ',ZBOT,ZTOP,' km.'
      READ,' Enter the desired altitude to be plotted ',ZPLOT
      LOCATE,ALT,ZPLOT,INDX
      ARRAY = PEX(*,INDX)
;
      IF ( MAX(ARRAY) LE 0.0 ) THEN BEGIN
         PRINT,' There is nothing down here, choose a higher altitude.'
      ENDIF ELSE BEGIN
         ARRAY = ARRAY + 1.0E-30
         LOGLIM,ARRAY,Y1,Y2,NTICK,MAXDEC=8
         !MTITLE  = 'ALTITUDE = '+FTOA(ALT(INDX),'(F6.1)')+' km'
         !Y.RANGE = [Y1,Y2]
         !Y.TICKS = NTICK
;         !Y.MINOR = 9
         LOGTICK,'IO'
         PLOT_IO,EGRID,ARRAY
;
         READ,' Send this plot to laser printer? (Y/N) ',ANS
         ANS = STRUPCASE(ANS)
         IF (ANS EQ 'Y') THEN BEGIN
            LASER     ;,FILEFORMAT='EPS'
            PLOT_IO,EGRID,ARRAY
            SEND
         ENDIF
;
         UNLOGTICK
      ENDELSE
;
      READ,' (Q)uit, (C)ontinue ',ANS
      ANS = STRUPCASE(ANS)
      IF (ANS EQ 'Q') THEN DONE = 1
   ENDWHILE
;
   END

