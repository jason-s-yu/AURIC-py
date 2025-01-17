;
;
;
@laser
@logtick
;**********************************************************************
;  MAIN PROGRAM
;**********************************************************************
;  Purpose:
;     This program plots the line-of-sight intensities (dayglow or
;     nightglow).
;//////////////////////////////////////////////////////////////////////
;
   !TYPE = 12
;
   FILES  = ['dayglo.int','niteglo.int','losden.dat','other file']
   NFILE  = N_ELEMENTS(FILES)
   TITLES = ['DAYGLOW','NIGHTGLOW','LIMB','']
   xint   = 'Intensity (R)'
   xcd    = 'Column Density (cm!u-2!n)'
   XTITLES = [xint,xint,xcd,xint,xint]
;
   SELECT_FILE,FILES,CHO
   IF (CHO NE 3) THEN BEGIN
      FILENAME = FILES(CHO)
   ENDIF ELSE BEGIN
      FILENAME = ''
      PRINT,' '
      READ,' Enter file name: ',FILENAME
   ENDELSE
;
   READINT,FILENAME,ZOBS,NLOOK,LOOK,TANALT,NFEAT,FEATS,INTEN
;
   LAS = ''
   YAX = ' '
   PRINT,' '
   READ,' Plot vs look angle (L) or tangent altitude (T)...',YAX
   YAX    = STRUPCASE(YAX)
   DOMAIN = LOOK
   IF (YAX EQ 'T') THEN DOMAIN = TANALT
;
   !XTITLE = XTITLES(CHO)
   IF (YAX EQ 'T') THEN BEGIN
      !YTITLE  = 'Tangent Altitude (km)'
      !Y.RANGE = [MIN(TANALT),MAX(TANALT)]
   ENDIF ELSE BEGIN
      !YTITLE  = 'Look Angle (deg)'
      !Y.RANGE = [MAX(LOOK),MIN(LOOK)]
   ENDELSE
;
   FOR IFEAT = 0, NFEAT-1 DO BEGIN
      !MTITLE = FEATS(IFEAT)+"   Z!dobs!n = "+FTOA(ZOBS,'(F8.2)')+" km"
	print, 'ZOBS+FTOA',ZOBS 
;      !MTITLE = FEATS(IFEAT)+"   Z!dobs!n = 500"+" km"
      ARRAY = INTEN(*,IFEAT)
      LOGLIM,ARRAY,X1,X2,NTICK,MAXDEC=4
      !X.RANGE = [X1,X2]
      !X.TICKS = NTICK
      LOGTICK,'OI'
      PLOT_OI,ARRAY,DOMAIN,LINE=0
;
      PRINT,'   '
      READ,' Send this plot to laser printer? (y/n) ',LAS
      LAS = STRUPCASE(LAS)
      IF (LAS EQ 'Y') THEN BEGIN
         LASER
         PLOT_OI,ARRAY,DOMAIN,LINE=0
         SEND
      ENDIF
   ENDFOR
   UNLOGTICK
;
   END

