;
;
;
@laser
@labeling
@logtick
;*********************************************************************
;  MAIN PROGRAM
;*********************************************************************
;  Purpose:
;     This routine plots the model atmosphere.
;/////////////////////////////////////////////////////////////////////
;
;   !TYPE = 12
   FILENAME = 'atmos.dat'
;
   ANS = ''
   READATM,FILENAME,NALT,ALT,NDEN,DENNAME,DEN,TN
   NALT = N_ELEMENTS(ALT)
;
   ZLOW  =   0.0     ; altitude region to be plotted.
   ZHIGH = 500.0
;
   ZMIN  = MIN(ALT)  ; altitude range
   ZMAX  = MAX(ALT)
;
   IF (ZMAX GE ZHIGH) THEN BEGIN
      LOCATE,ALT,ZHIGH,INDX1
   ENDIF ELSE BEGIN
      INDX1 = 0
   ENDELSE
;
   IF (ZMIN LE ZLOW) THEN BEGIN
      LOCATE,ALT,ZLOW,INDX2
   ENDIF ELSE BEGIN
      INDX2 = NALT - 1
   ENDELSE
;
   ARRAY1 = DEN(INDX1:INDX2,0)
   ARRAY2 = DEN(INDX1:INDX2,6)
;
   LOGLIM,ARRAY1,LO1,HI1,NTICK1,MAXDEC=8
   IF (HI1 GT 1E14) THEN BEGIN
      HI1 = 1E14
      LO1 = HI1/(10.0^NTICK1)
   ENDIF
;
   LOGLIM,ARRAY2,LO2,HI2,NTICK2,MAXDEC=8
   IF (HI2 GT 1E10) THEN BEGIN
      HI2 = 1E10
      LO2 = HI2/(10.0^NTICK2)
   ENDIF
;
   DUM = ''
   LAS = ''
   LASER:
;
   IF (LAS EQ 'Y') THEN LASER,PPG=3,FONTSIZE=16    ;,FILEFORMAT='EPS'
;
   !Y.RANGE = [ZLOW,ZHIGH]
   !YTICKS  = 5
   !y.minor = 4
   !XTITLE  = 'Density (cm!U-3!N)'
   !YTITLE  = 'Altitude (km)'
;
   !X.RANGE = [LO1,HI1]
   !X.TICKS = NTICK1
   !X.MINOR = 0
   !MTITLE = 'Neutral Densities'
   LOGTICK,'OI'
   PLOT_OI,[0,0],[0,0]
   FOR I = 0, 4 DO BEGIN
      OPLOT,DEN(*,I),ALT,LINE=I
   ENDFOR
   LABEL = ['N!d2!n','O!d2!n','O','O!d3!n','NO']
   LABELING,2,LABEL,CHARSIZE=0.5
   UNLOGTICK 
;
   IF (LAS NE 'Y') THEN READ,'HIT RETURN...',DUM
;
   !X.RANGE = [LO2,HI2]
   !X.TICKS = NTICK2
   !X.MINOR = 0
   !MTITLE = 'Neutral Densities'
   LOGTICK,'OI'
   PLOT_OI,[0,0],[0,0]
   FOR I = 5, 8 DO BEGIN
      LINETYPE = I - 5
      OPLOT,DEN(*,I),ALT,LINE=LINETYPE
   ENDFOR
   LABEL = ['N','He','H','Ar']
   LABELING,2,LABEL,CHARSIZE=0.5
   UNLOGTICK 
;
   IF (LAS NE 'Y') THEN READ,'HIT RETURN...',DUM
;
   !MTITLE = 'Neutral Temperature'
   !X.RANGE = [0,1400]
   !X.TICKS = 7
   !X.MINOR = 4
   !XTITLE  = 'Temperature (K)'
   PLOT,TN,ALT,LINE=0
;
   IF (LAS EQ 'Y') THEN SEND
;
   PRINT,' '
   READ,' Send plot(s) to laser printer? (y/n) ',LAS
   LAS = STRUPCASE(LAS)
   IF (LAS EQ 'Y') THEN GOTO,LASER
;
   END

