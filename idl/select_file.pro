;
;
;*********************************************************************
   PRO SELECT_FILE,FILES,CHO
;*********************************************************************
;  Purpose:
;     This routine prompts the user a listing of availables files
;     to choose from.
;
;  Arguments:
;     (in)  files = a string array that contains the available files.
;     (out) cho   = index of the file selected by the user.
;/////////////////////////////////////////////////////////////////////
;
   NFILE = N_ELEMENTS(FILES)
   CHO   = 0
   DONE  = 0
;
   WHILE (DONE EQ 0) DO BEGIN
      PRINT,' '
      PRINT,' Please select one of the following files:'
      PRINT,' '
      FOR I =  0, NFILE-1 DO BEGIN
         ISTR = ITOA(I+1)
         PRINT,' ('+ISTR+') '+FILES(I)
      ENDFOR
      PRINT,' '
      READ,' Enter file index -> ',CHO
;
      IF (CHO LT 1 OR CHO GT NFILE) THEN BEGIN
         PRINT,' '
         PRINT,' Wrong choice, please try again.'
      ENDIF ELSE BEGIN
         DONE = 1
      ENDELSE
   ENDWHILE
;
   CHO = CHO - 1     ; convert to IDL index
;
   RETURN
   END
