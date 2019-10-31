;
;
;
@laser
@labeling
@logtick
;*******************************************************************
;  MAIN PROGRAM
;*******************************************************************
;  Purpose:
;     This routine plots the slant column densities.
;
;  Significant variables:
;     FILENAME = slant column density file.
;     NSTOP    = index of the last altitude point which the slant
;                column density is calculated for.
;     ALT      = altitude grid.
;     CND      = slant column densities, CND = CND(Z,C) where
;                Z = altitude
;                C = density constituents
;///////////////////////////////////////////////////////////////////
;
   !TYPE = 12
   FILENAME = 'colden.dat'
;
   ANS = ''
;
   READCND,FILENAME,SZA,NALT,ALT,NCND,CNDNAME,CND
;
   ZLO = 100.0
   ZHI = 500.0
   LOCATE,ALT,ZLO,ILO
   LOCATE,ALT,ZHI,IHI
;
   for ic = 0, NCND-1 do begin
      tmp = cnd(*,ic)
      tmp = tmp(ihi:ilo)
      if (n_elements(din) eq 0) then begin
         din = tmp
      endif else begin
         din = [din,tmp]
      endelse
   endfor
;
   LOGLIM,din,XMIN,XMAX,XTICK,MAXDEC=15
;
   LAS = ''
   LASER:
;
   IF (LAS EQ 'Y') THEN LASER
;
   !X.RANGE = [XMIN,XMAX]
   !Y.RANGE = [zlo,zhi]
   !X.TICKS = XTICK
   !Y.TICKS = 4
   !Y.MINOR = 5
   !MTITLE = 'SZA = '+STRTRIM(STRING(SZA),2)+'!uo!n'
   !XTITLE = 'Slant Column Density (cm!U-2!N)'
   !YTITLE = 'Altitude (km)'
;
   LOGTICK,'OI'
   PLOT_OI,[0,0],[0,0]
   FOR IC = 0, NCND-1 DO BEGIN
      OPLOT,CND(*,IC),ALT,LINE=IC
   ENDFOR
   LABEL = CNDNAME
   LABELING,2,LABEL
   UNLOGTICK
;
   IF (LAS EQ 'Y') THEN SEND
;
   PRINT,' '
   READ,' Send plot to laser printer? (y/n) ',LAS
   LAS = STRUPCASE(LAS)
   IF (LAS EQ 'Y') THEN GOTO,LASER
;
;
   END
