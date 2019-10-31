;
;
;
@laser
@logtick
@angstrom
;*********************************************************************
;   MAIN PROGRAM
;*********************************************************************
;   Plot the solar EUV flux.
;/////////////////////////////////////////////////////////////////////
;
    !TYPE = 12
    FILENAME = 'solar.dat'
;
    READEUV,FILENAME,NLAM,LAM,EUV
;
    LOGLIM,EUV,YMIN,YMAX,YTICK,MAXDEC=5
;
    LAS = ''
;
    !X.RANGE = [0,1100]
    !X.TICKS = 11
    !X.MINOR = 0
    !Y.RANGE = [YMIN,YMAX]
    !Y.TICKS = YTICK
    !Y.MINOR = 9
;
    !XTITLE = 'Wavelength ('+angstrom(0)+')'
    !YTITLE = 'Solar EUV Flux (photons cm!U-2!N sec!U-1!N)'
;
    LOGTICK,'IO'
    PLOT_IO,[-1,-2],[1,2]
    FOR I = 0, NLAM-1 DO BEGIN
       OPLOT,[LAM(I),LAM(I)],[1e-30,EUV(I)],LINE=0
    ENDFOR
;
    PRINT,' '
    READ,' send this plot to laser printer? (y/n) ',LAS
    LAS = STRUPCASE(LAS)
    IF (LAS EQ 'Y') THEN BEGIN
       LASER,/LANDSCAPE,/VECTORFONT
;       LASER,/VECTORFONT,FILEFORMAT='EPS'
       PLOT_IO,[-1,-2],[1,2]
       FOR I = 0, NLAM-1 DO BEGIN
          OPLOT,[LAM(I),LAM(I)],[1e-30,EUV(I)],LINE=0
       ENDFOR
       SEND
    ENDIF
    UNLOGTICK
;
    END

