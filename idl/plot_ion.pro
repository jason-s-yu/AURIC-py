;
;
;
@logtick
@laser
;*********************************************************************
;  MAIN PROGRAM
;*********************************************************************
;  Plot the model ionosphere.
;/////////////////////////////////////////////////////////////////////
;
   !TYPE = 12
   FILENAME = 'ionos.dat'
   READION,FILENAME,NALT,ALT,ION
;
   LAS = ''
   LASER:
;
   IF (LAS EQ 'Y') THEN LASER     ;,FILEFORMAT='EPS'
;
   !MTITLE = 'Ionosphere'
   !XTITLE = 'Electron Density (cm!U-3!N)'
   !YTITLE = 'Altitude (km)'
   LOGLIM,ION,XMIN,XMAX,NTICK,MAXDEC=2
   !X.RANGE = [XMIN,XMAX]
   !X.TICKS = NTICK
   !X.MINOR = 9
   !Y.RANGE = [100,500]
   !Y.TICKS = 4
   !Y.MINOR = 5
;
   LOGTICK,'OI'
   PLOT_OI,ION,ALT,LINE=0
   UNLOGTICK
;
   IF (LAS EQ 'Y') THEN SEND
;
   PRINT,' '
   READ,' Send plot(s) to laser printer? (y/n) ',LAS
   LAS = STRUPCASE(LAS)
   IF (LAS EQ 'Y') THEN GOTO,LASER
;
;
   END

