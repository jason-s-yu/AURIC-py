;
;
;*********************************************************************
   PRO READINT,FILENAME,ZOBS,NLOOK,LOOK,TANALT,NFEAT,FEATS,INTEN
;*********************************************************************
;  Purpose:
;     This routine reads a line-of-sight intensity file.
;
;  Arguments:
;     (in)  filename = file to be read.
;     (out) zobs     = observer altitude.
;     (out) nlook    = number of zenith angles.
;     (out) look     = zenith angles.
;     (out) tanalt   = tangent altitudes (km).
;     (out) nfeat    = number of features.
;     (out) feats    = names of the features.
;     (out) inten    = line-of-sight intensities, it is a function of
;                      (look angle, features)
;/////////////////////////////////////////////////////////////////////
;
   READSTD,FILENAME,NLOOK,LOOK,NFEAT,FEATS,INTEN,NINFO,INFO
;
   INDX = STRPOS(INFO(0),'=')
   ZOBS = FLOAT(STRMID(INFO(0),INDX+1,STRLEN(INFO(0))))
;
   TANALT = (6375.0+ZOBS)*SIN(!DTOR*LOOK)-6375.0
;
   RETURN
   END
