;
;
;*********************************************************************
   PRO WRITESTD,FILENAME,NX,X,NY,LABELS,Y,$
                NINFO=NINFO,INFO=INFO,$
                XTITLE=XTITLE,YTITLE=YTITLE,$
                XFORMAT=XFORMAT,YFORMAT=YFORMAT
;*********************************************************************
;  Purpose:
;     This routine writes a file in the AURIC STD format.
;
;  Arguments:
;     (in)  filename = file to write.
;     (in)  nx       = number of elements in independent variable array.
;     (in)  x        = independent variable array.
;     (in)  nx       = number of dependent elements
;     (in)  labels   = labels for depenedent elements.
;     (in)  y        = dependent array.
;     (in)  ninfo    = keyword for the number of information lines.
;     (in)  info     = keyword for the array of information strings.
;     (in)  xtitle   = keyword for x array title.
;     (in)  ytitle   = keyword for y array title.
;     (in)  xformat  = keyword for x array format (e.g. '6F12.3').
;     (in)  yformat  = keyword for y array format (e.g. '6E12.3').
;/////////////////////////////////////////////////////////////////////
;
   IF (NOT KEYWORD_SET(XTITLE))  THEN XTITLE  = 'No Title Provided'
   IF (NOT KEYWORD_SET(YTITLE))  THEN YTITLE  = 'No Title Provided'
   IF (NOT KEYWORD_SET(XFORMAT)) THEN XFORMAT = '6F12.3'
   IF (NOT KEYWORD_SET(YFORMAT)) THEN YFORMAT = '6E12.3'
   IF (NOT KEYWORD_SET(NINFO))   THEN NINFO   = 0
;
   CLOSE,12
   OPENW,12,FILENAME
   IF (NINFO GE 1) THEN BEGIN
      PRINTF,12, FIX(NX), FIX(NY), FIX(NINFO)
   ENDIF ELSE BEGIN
      PRINTF,12, FIX(NX), FIX(NY)
   ENDELSE
   IF (NINFO GE 1) THEN BEGIN
      IF (KEYWORD_SET(INFO)) THEN BEGIN
         FOR IINFO = 0, NINFO-1 DO BEGIN
            PRINTF,12,INFO(IINFO)
         ENDFOR
      ENDIF ELSE BEGIN
         PRINT,' '
         PRINT,'Error in subroutine WRITESTD.'
         PRINT,'keyword INFO is not defined.'
         PRINT,' '
         STOP
      ENDELSE
   ENDIF
;
   PRINTF,12,XTITLE
   PRINTF,12,FORMAT='('+XFORMAT+')',X
   PRINTF,12,YTITLE
   FOR I = 0, NY-1 DO BEGIN
      PRINTF,12,LABELS(I)
      PRINTF,12,FORMAT='('+YFORMAT+')',Y(*,I)
   ENDFOR
   CLOSE,12
;
   RETURN
   END
