;
;
;********************************************************************
   PRO READATM,FILENAME,NALT,ALT,NDEN,DENNAME,DEN,TN
;********************************************************************
;  This routine reads an atmosphere file (in Auric format).
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) nalt     = number of altitudes.
;     (out) alt      = altitude grid.
;     (out) nden     = number of constituents.
;     (out) denname  = names of the densities.
;     (out) den      = number densities (cm^-3) = f(z,c)
;     (out) tn       = temperature.
;////////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NALT,ALT,NDEN,DENNAME,DEN
;
   NDEN    = NDEN - 1
   DENNAME = DENNAME(1:NDEN)
   TN      = DEN(*,0)
   DEN     = REFORM(DEN(*,1:NDEN))
;
   RETURN
   END
