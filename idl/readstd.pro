;
;
;*********************************************************************
   PRO READSTD,FILENAME,NX,X,NY,LABELS,Y,NINFO,INFO
;*********************************************************************
;  Purpose:
;     This routine reads a file in teh AURIC STD format.
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) nx       = number of elements in independent variable array.
;     (out) x        = independent variable array.
;     (out) nx       = number of dependent elements
;     (out) labels   = labels for depenedent elements.
;     (out) y        = dependent array.
;     (out) ninfo    = number of information lines.
;     (out) info     = array of information strings.
;/////////////////////////////////////////////////////////////////////
;
   NFEAT = 0
   NALT  = 0
   NSTOP = 0
   LINE  = ''
   DUM   = 0.0
   ERR   = 0
;
   IOERR = 0
   ON_IOERROR, NO_INFO
   CLOSE,12
   OPENR,12,FILENAME
   READF,12,NX, NY, NINFO
   INFO = STRARR(NINFO)
   FOR IINFO = 0, NINFO-1 DO BEGIN
      READF,12,LINE
      INFO(IINFO) = LINE
   ENDFOR
   GOTO, CONTINUE
   NO_INFO:
      IF (IOERR EQ 0) THEN BEGIN
         IOERR = 1
         CLOSE,12
         OPENR,12,FILENAME
         READF,12,NX, NY
      ENDIF ELSE BEGIN
         PRINT,'IO error encountered.'
         STOP
      ENDELSE
;
   CONTINUE:
   X      = FLTARR(NX)
   LABELS = STRARR(NY)
   Y      = FLTARR(NX,NY)
   TMP    = FLTARR(NX)
;
   READF,12,LINE
   READF,12,X
   READF,12,LINE
   FOR I = 0, NY-1 DO BEGIN
      READF,12,LINE
      LABELS(I) = STRTRIM(LINE,2)
      READF,12,TMP
      Y(*,I) = TMP
   ENDFOR
   CLOSE,12
;
   RETURN
   END
