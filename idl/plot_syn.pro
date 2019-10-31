;
;
;
@laser
@logtick
;*********************************************************************
;  MAIN PROGRAM
;*********************************************************************
;  This program plots the synthetic spectra for different look angles.
;/////////////////////////////////////////////////////////////////////
;
   !TYPE = 12
   FILES  = ['n2_lbh.syn', $
             'n2_vk.syn', $
             'n2_1pg.syn', $
             'n2_2pg.syn', $
             'n2p_1ng.syn', $
             'n2p_mnl.syn', $
             'no_bands.syn', $
             'o2_nglow.syn', $
             'merge.syn']
   TITLES = ['N!d2!n LBH', 'N!d2!n VK', 'N!d2!n 1PG', 'N!d2!n 2PG', $
             'N!d2!n!u+!n 1NG', 'N!d2!n!u+!n Meinel', 'NO Bands',  $
             'O!d2!n UV','Total Spectra']
   NFILES = N_ELEMENTS(FILES)
;
   SELECT_FILE,FILES,CHO
   FILENAME = FILES(CHO)
;  -------------------------------------------------------------------
   AXIS = ""
   PRINT,' '
   READ,' L(o)g or L(i)near scale? ',AXIS
   AXIS = STRUPCASE(AXIS)
;  -------------------------------------------------------------------
   PRINT,' '
   PRINT,' Reading the file: '+FILENAME
;
   READSYN,FILENAME,ZOBS,RES,NLAM,LAM,NLOOK,LOOK,TANALT,SPECT
;  -------------------------------------------------------------------
   ANS   = ''
   NSMTH = 1
   IF (RES EQ 1) THEN BEGIN
      PRINT,' '
      PRINT,' The current resolution is 1 Angstrom.'
      READ,' Do you wish to smooth the synthetic spectra (y/n)? ', ANS
      ANS = STRUPCASE(ANS)
      IF (ANS EQ 'Y') THEN BEGIN
         READ,' Enter the desired resolution ',NSMTH
      ENDIF
   ENDIF ELSE BEGIN
      NSMTH = RES
   ENDELSE
;
   LAMBEG = LAM(0)
   LAMEND = LAM(NLAM-1)
   PRINT,'  '
   PRINT,' The wavelength region is [' + ITOA(LAMBEG) + $
         ',' + ITOA(LAMEND) + ']'
   READ,' Do you wish to change it (y/n)? ',ANS
   ANS = STRUPCASE(ANS)
   IF (ANS EQ 'Y') THEN BEGIN
      READ,' Enter beginning wavelength --- ',LAMBEG
      READ,' Enter stopping wavelength  --- ',LAMEND
   ENDIF
;
   !X.RANGE = [LAMBEG,LAMEND]
   !XTITLE  = 'Wavelength (' + ANGSTROM(0) + ')'
   !YTITLE  = 'Intensity (R/' + ANGSTROM(0) + ')'
;  -------------------------------------------------------------------
   FOR I = 0, NLOOK-1 DO BEGIN
      X = TANALT(I)
      X = FTOA(X,'(F7.2)')
      !MTITLE = TITLES(CHO)+'   Tangent Altitude = '+X+' km'+  $
                '   Res = '+ITOA(NSMTH)+' '+ANGSTROM(0)
;
      ARRAY = SPECT(*,I)
      IF (RES EQ 1 AND NSMTH GT 1) THEN BEGIN
         ARRAY = SMOOTH1D(ARRAY,NSMTH)
         ARRAY = SMOOTH1D(ARRAY,NSMTH)
      ENDIF
;
      LAS  = 'N'
      DONE = 0
      WHILE (DONE EQ 0) DO BEGIN
;         print,'done = ',done,'   las = ',las
;
         IF (LAS EQ 'Y') THEN BEGIN
            LASER,/LANDSCAPE,/VECTORFONT
         ENDIF
;
         IF (AXIS EQ "O") THEN BEGIN
            ARRAY = ARRAY + 1E-30
            LOGLIM,ARRAY,ALIM,BLIM,NTICK,MAXDEC=4
            !Y.RANGE = [ALIM,BLIM]
            !Y.TICKS = NTICK
            !Y.MINOR = 9
            LOGTICK,'IO'
            PLOT_IO,LAM,ARRAY,LINE=0
            UNLOGTICK
         ENDIF ELSE BEGIN
            LINLIM,ARRAY,ALIM,BLIM,NTICK
            !Y.RANGE = [ALIM,BLIM]
            !Y.TICKS = NTICK
            PLOT,LAM,ARRAY,LINE=0
         ENDELSE
;
         IF (LAS NE 'Y') THEN BEGIN
            PRINT,'   '
            READ,' Send this plot to laser printer? (y/n) ',LAS
            LAS = STRUPCASE(LAS)
            IF (LAS NE 'Y') THEN BEGIN
               DONE = 1
            ENDIF
         ENDIF ELSE BEGIN
            SEND
            DONE = 1
         ENDELSE
      ENDWHILE
;
   ENDFOR
;
;
   END
