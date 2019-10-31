
;
;
@logtick
@laser
@labeling
;*********************************************************************
;  MAIN PROGRAM
;*********************************************************************
;  Purpose:
;     This program plots the contents in those data files in the 
;     AURIC STD format.
;/////////////////////////////////////////////////////////////////////
;
   !TYPE  = 12
   FILES  = ['photoion.vpr', $
             'photo.ver', $
             'pdis.vpr', $
             'e_impact.ver', $
             'chemout.ver', $
             'dayglo.ver', $
             'niteglo.ver', $
             'chemin.vpr', $
             'eloss.vpr', $
             'chemden.dat', $
             'hzbcham.dat']
   NFILE  = N_ELEMENTS(FILES)
   TITLES = FILES
;
   VPRSTR = 'Volume Production Rate (cm!U-3!N s!U-1!N)'
   VERSTR = 'Volume Emission Rate (cm!U-3!N s!U-1!N)'
   DENSTR = 'Density (cm!U-3!N)'
   PDISSTR = 'Primary Dissociation Rate (cm!u-3!n s!u-1!n)'
   LABELS = [VPRSTR,VPRSTR,VPRSTR,VERSTR,VERSTR,VERSTR,VERSTR,VERSTR, $
             VPRSTR,PDISSTR,VPRSTR,DENSTR,DENSTR]
;
   SELECT_FILE,FILES,CHO
   FILENAME = FILES(CHO)
   !XTITLE  = LABELS(CHO)
   !YTITLE  = 'Altitude (km)'
;
   READSTD,FILENAME,NSTOP,ALT,NFEAT,FEATS,OBJ
;
;  specify the plotting mode.
;   MODE = 'ALL'    ; all features on one plot
   MODE = 'ONE'    ; one feature per plot
;
   !Y.RANGE = [0,600]
   !Y.TICKS = 6
   !Y.MINOR = 0
;
   LAS = ''
   IF (MODE EQ 'ONE') THEN BEGIN
;     put one feature per plot.
      FOR IFEAT = 0, NFEAT-1 DO BEGIN
         X = OBJ(*,IFEAT)
         LOGLIM,X,LO,HI,NTICK,MAXDEC=4
         !X.RANGE = [LO,HI]
         !X.TICKS = NTICK
         !X.MINOR = 9
         !MTITLE  = FEATS(IFEAT)
         LOGTICK,'OI'
         PLOT_OI,X,ALT,LINE=0
;
         PRINT,'   '
         READ,' Send plot to laser printer? (y/n) ',LAS
         LAS = STRUPCASE(LAS)
         IF (LAS EQ 'Y') THEN BEGIN
            LASER
            PLOT_OI,X,ALT,LINE=0
            SEND
         ENDIF
         UNLOGTICK
      ENDFOR
   ENDIF ELSE BEGIN
;     put all features on one plot.
      LOGLIM,OBJ,LO,HI,NTICK,MAXDEC=3
      !MTITLE  = ''
      !X.RANGE = [LO,HI]
      !X.TICKS = NTICK
      !X.MINOR = 9
;
      DONE = 0
      WHILE (DONE EQ 0) DO BEGIN
         IF (LAS EQ 'Y') THEN LASER
         LOGTICK,'OI'
         PLOT_OI,[-1,-1],[0,0]
         FOR IFEAT = 0, NFEAT-1 DO BEGIN
            X = OBJ(*,IFEAT)
            OPLOT,X,ALT,LINE=IFEAT
         ENDFOR
         LABELING,4,FEATS
         IF (LAS EQ 'Y') THEN SEND
;
         PRINT,''
         READ,' Send plot to laser printer? (y/n) ',LAS
         LAS = STRUPCASE(LAS)
         IF (LAS NE 'Y') THEN BEGIN
            DONE = 1
         ENDIF
      ENDWHILE
   ENDELSE
;
;
   END

