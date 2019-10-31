;
;
;*******************************************************************
   PRO READCND,FILENAME,SZA,NALT,ALT,NCND,CNDNAME,CND
;*******************************************************************
;  Purpose:
;     This routine reads the slant column densities file.
;
;  Arguments:
;     (in)  FILENAME = file to be read.
;     (out) SZA      = solar zenith angle (deg).
;     (out) NALT     = number of altitudes.
;     (out) ALT      = altitude grid.
;     (out) NCND     = number of column densities.
;     (out) CNDNAME  = labels for column densities.
;     (out) CND      = slant column densities.
;                      cnd = cnd(altitude,atmospheric constituents).
;///////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NALT,ALT,NCND,CNDNAME,CND,NINFO,INFO
;
   INDX = STRPOS(INFO(0),'=')
   SZA  = FLOAT(STRMID(INFO(0),INDX+1,STRLEN(INFO(0))))
;
   RETURN
   END
