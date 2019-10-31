;
;
;*******************************************************************
   FUNCTION ANGSTROM,DUM
;*******************************************************************
;  Returns a string value which can be used to display an Angstrom
;  symbol on a plot.
;
   ANGSTROM ='!6!SA!R!U!9 % !N!3'
;   ANGSTROM = '!SA!R!A!9%!N!X'
;   ANGSTROM = '!17!SA!R!U!9 %!X'   ; this one does not work as well
;
   RETURN,ANGSTROM
   END
