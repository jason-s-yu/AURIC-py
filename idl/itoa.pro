;
;
;**********************************************************************
   FUNCTION ITOA,ARG
;**********************************************************************
;  This function converts an integer to a string without the leading or
;  trailing spaces. A real argument is acceptable (it is converted to
;  an integer first).
;
   ARG  = FIX(ARG)
   ITOA = STRING(ARG)
   ITOA = STRTRIM(ITOA,2)
;
   RETURN,ITOA
   END
