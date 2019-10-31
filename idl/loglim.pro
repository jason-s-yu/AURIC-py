;
;
;//////////////////////////////////////////////////////////////////////
;   IDL procedure "LOGLIM.PRO"  (for LOG LIMit plot)
;
;   Author:        M. Shen
;   Date written:  Apr. 1992
;   Version:       1.0
;
;   Purpose:
;      This routine determines the axis limits on a logarithmic plot.
;
;   Calling syntax:
;      In order to set the plotting limits on a log-scaled axis, type
;
;           loglim,array,lolim,hilim,ntick
;
;           where
;              array = the 1-D array to be plotted (input)
;              lolim = lower limit (output)
;              hilim = upper limit (output)
;              ntick = number of ticks (output)
;      This procedure has the following switch(es):
;      maxdec = an integer that represents the maximum number of decades
;               which the user will allow. If the arguement array spans
;               more than this many decades, the lower limit (lolim)
;               will be raised to meet this requirement.
;
;   Comments:
;      The limits returned by this routine will always be integer 
;      powers of 10 selected in a way such that the plotted curve 
;      is completely enclosed by the limits.
;//////////////////////////////////////////////////////////////////////
;
;**********************************************************************
   PRO LOGLIM,ARRAY,LOLIM,HILIM,NTICK,MAXDEC=MAXDEC
;**********************************************************************
;
   DATA = ARRAY
;
;  drop the zeroes from the array.
   TMP = WHERE(DATA GT 0.0)
   IF (MIN(TMP) GE 0) THEN DATA = DATA(TMP)
;
   IF (MIN(DATA) EQ 0.0 AND MAX(DATA) EQ 0.0) THEN BEGIN
;     The object array is all zero, simply set the plotting limits
;     arbitrarily.
;
      LOLIM = 1E0
      HILIM = 1E1
      NTICK = 1
   ENDIF ELSE BEGIN
      AMIN = MIN(DATA)     ; minimum of the array
      AMAX = MAX(DATA)     ; maximum of the array
;
      PMIN = ALOG10(AMIN)
      PMAX = ALOG10(AMAX)
;
      IF (PMIN GE 0.0) THEN BEGIN
         PMIN = FIX(PMIN)
      ENDIF ELSE BEGIN
         PMIN = FIX(PMIN-1.0)
      ENDELSE
;
      IF (PMAX GT -1.0) THEN BEGIN
         PMAX = FIX(PMAX+1.0)
      ENDIF ELSE BEGIN
         PMAX = FIX(PMAX)
      ENDELSE
;
      LOLIM = 10.0^PMIN  
      HILIM = 10.0^PMAX
      NTICK = ABS(PMAX - PMIN)
;
      IF ( KEYWORD_SET(MAXDEC) ) THEN BEGIN
         IF (MAXDEC LT NTICK) THEN BEGIN
            LOLIM = HILIM/10.0^MAXDEC
            NTICK = MAXDEC
         ENDIF
      ENDIF
   ENDELSE
;
   RETURN
   END
