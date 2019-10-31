;
;
;*********************************************************************
   PRO READION,FILENAME,NALT,ALT,ION
;*********************************************************************
;  Purpose:
;     This routine reads the ionosphere file.
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) nalt     = number of altitudes.
;     (out) alt      = altitude grid.
;     (out) ion      = free electron density.
;/////////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NALT,ALT,NLAB,LAB,ION
;
   RETURN
   END
