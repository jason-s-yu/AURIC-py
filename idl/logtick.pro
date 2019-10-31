;
;
;///////////////////////////////////////////////////////////////////
;     IDL procedure collection "LOGTICK.PRO"
;
;     Author:       M. Shen
;     Version:      1.0
;     Date written: Apr. 1991 
;
;     Purpose:  
;            The latest version of IDL does not do a good job on the 
;        tick names for a logarithmic axis. The exponents are as big 
;        as the mantissae which is undesirable. This routine remedies
;        that by setting the tickname system variables.
;
;     Calling parameters:
;        kind = 'II','IO','OI' or 'OO'
;               It denotes the axis type just like these built-in
;               procedures: plot, plot_io, plot_oi, plot_oo
;
;     Restrictions / Comments:
;        When using logarithmic scaling, the log axis limits must be 
;        set at powers of 10 such that there are no partial decades on
;        the axis.
;///////////////////////////////////////////////////////////////////
;*******************************************************************
   PRO LOGTICK,KIND
;*******************************************************************
;
;  Determine the axis scaling type
   KIND = STRUPCASE(KIND)
   CASE KIND OF
      'II': BEGIN
               XAXIS = 0
               YAXIS = 0
            END
      'IO': BEGIN
               XAXIS = 0
               YAXIS = 1
            END
      'OI': BEGIN
               XAXIS = 1
               YAXIS = 0
            END
      'OO': BEGIN
               XAXIS = 1
               YAXIS = 1
            END
      ELSE: BEGIN
               PRINT," FROM PROCEDURE LOGTICK, KIND MUST BE 'II', ", $
                     "'IO', 'OI' OR 'OO'!"
               PRINT,'PROGRAM STOPPED.'
               STOP
            END
   ENDCASE
;
;  Determine the boundaries
   X1 = !XMIN    &    X2 = !XMAX
   Y1 = !YMIN    &    Y2 = !YMAX
;
   IF (XAXIS EQ 1) THEN BEGIN
      TICKNAME,X1,X2,NAMEARR
      !X.TICKNAME = NAMEARR
   ENDIF
;
   IF (YAXIS EQ 1) THEN BEGIN
      TICKNAME,Y1,Y2,NAMEARR
      !Y.TICKNAME = NAMEARR
   ENDIF
;
   RETURN
   END
;*******************************************************************
   PRO TICKNAME,A,B,NAMEARR
;*******************************************************************
;
   A      = FIX(ALOG10(A))
   B      = FIX(ALOG10(B))
   NTICK  = ABS(B-A)+1
   EXPARR = INTARR(NTICK)   ; exponent array
   EXPARR(0) = A
   FOR I=1,NTICK-1 DO BEGIN
      EXPARR(I) = EXPARR(I-1)+1
   ENDFOR
   NAMEARR = '10!U'+ITOA(EXPARR)+'!N'
;
   RETURN
   END
;*******************************************************************
   PRO UNLOGTICK
;*******************************************************************
;
   !X.TICKNAME = ''
   !Y.TICKNAME = ''
;
   RETURN
   END
