;
;
;//////////////////////////////////////////////////////////////////////
;   IDL procedure "LABELING.PRO"
;
;   Author:        M. Shen
;   Date written:  Aug. 1991
;   Version:       2.0
;
;   Purpose:
;      This subroutine outputs a window that labels the different line 
;      types used in a plot.
;
;   Calling syntax:
;      (1) link this procedure to the user's plotting program
;      (2) when the plot is completed, type this line...
;          labeling,corner,label
;          where
;             corner = an integer, it denotes the position of labels
;                      relative to the plot.
;                      1 -> upper left    2 -> upper right
;                      3 -> lower right   4 -> lower left
;             label  = array of strings to be written
;          note the user must arrange the strings in the variable 
;          'label' in an order which corresponds to the way idl 
;          defines its line types; ie, the first string should 
;          correspond to the solid line which IDL defines to have 
;          linetype = 0.
;
;          This procedure has a number of optional switches which are:
;             charsize = character size (default is 0.9)
;             xpos     = starting position of the window on x-axis
;             ypos     = starting position of the window on y-axis
;             cancel   = setting cancel=1 will suppress the output
;                        by procedure labeling. This option is for 
;                        the users who only desire the coordinates.
;             header   = number of elements in parameter 'label' to be
;                        considered the header (no lines will be drawn
;                        next to them)
;             linetype = an integer array that contains the IDL line
;                        types to be drawn. Note that the number of 
;                        elements of parameter 'linetype' must be equal
;                        to that of parameter 'label'
;             kolor    = an integer array that contains the IDL line
;                        colors to be drawn, similar to the parameter
;                        'linetype'.
;
;           sample program that calls procedure labeling:
;                -----------------------------------------------------
;              ; program sample
;                @[address]labeling    ; linking to labeling.pro
;                plot,x1,y1,line=0
;                oplot,x2,y2,line=1
;                oplot,x3,y3,line=2
;                oplot,x2,y2,line=3
;                label = ['set 1','set 2','set 3','set 4']
;                xpos  = 300.0
;                charsize = 1.5
;                labeling,3,label,xpos=xpos,charsize=charsize
;                end ; of program sample
;                -----------------------------------------------------
;
;   Comments:
;      (1)  When using logarithmic scaling, the log axis limits must 
;           be set at powers of 10 such that there are no partial
;           decades on the axis. However, if you must have partial
;           decades, still give this routine a try. It may work anyway
;           (no guarantees).
;      (2)  The main routine in this file (procedure labeling) is long
;           because of the extensive use of keywords. The nature of IDL
;           keywords impede the use sub-modules because they are hard
;           to pass.
;
;   Modification History:
;      Version 1.2 ---
;           This version was modified by M. Shen on Oct 23,1991 for the 
;      purpose of removing an unnecessary calling variable. this variable
;      ( called "kind" ) contained information of the axis scaling type. 
;      Due to this change, this version is no longer compatible with the 
;      older versions. To remedy the programs which called the older 
;      labeling.pro, simply remove the parameter "kind" from the call 
;      statements.
;
;      Version 2.0 ---
;           This version was modified by M. Shen on Dec 9, 1991. A number 
;      of switches were added to make this program more flexible and easy
;      to use.
;
;      Version 2.1 ---
;           This version was modified by S. Evans on Jan 20, 1997.
;           Added psymtype for plots using symbols.
;**********************************************************************
   PRO LABELING,CORNER,LABEL,XARR,YARR,CHARSIZE=CHARSIZE,          $
                XPOS=XPOS,YPOS=YPOS,HEADER=HEADER,CANCEL=CANCEL,   $
                LINETYPE=LINETYPE,KOLOR=KOLOR,PSYMTYPE=PSYMTYPE
;**********************************************************************
   !LINETYPE = 0
   !PSYM     = 0
;  ===========================================================
   NLINETYPE = 6             ; number of IDL line types
   NLABEL = N_ELEMENTS(LABEL)
   XARR   = FLTARR(3)
   YARR   = FLTARR(NLABEL)
;
;  Parameters
   IF ( NOT KEYWORD_SET(CHARSIZE) ) THEN CHARSIZE = 0.90
   IF ( NOT KEYWORD_SET(KOLOR) ) THEN BEGIN
      IF (!D.NAME EQ 'PS') THEN BEGIN
         KOLOR = INTARR(NLABEL)*0
      ENDIF ELSE BEGIN
         KOLOR = INTARR(NLABEL)*0 + 255
      ENDELSE
   ENDIF
;
   XRAT    = .051   ; ratio of x margin over x-axis length 
   YRAT    = .083   ; ratio of y margin over y-axis length
   SEGRAT  = .081   ; ratio of line segment length over x-axis length
   GAPRAT  = .156   ; ratio of gap length over line segment length
   DELRAT  = .063   ; ratio of spacing over y-axis length
   LEFTDIS = .260   ; ratio of ABS(X2-XARR(0)) over xsize
   ACON    = .015   ; constant
   BCON    = .139   ; constant
   MINLEFT = .22    ; minimum value for leftdis
   MAXLEFT = .95    ; maximum value for leftdis
;  ===========================================================
;  Calculate the x position where the window should start
   IF (CORNER EQ 2 OR CORNER EQ 3) THEN BEGIN
      MAXLEN  = MAX(STRLEN(LABEL))
      LEFTDIS = ACON*MAXLEN+BCON
      IF (LEFTDIS LT MINLEFT) THEN LEFTDIS = MINLEFT
      IF (LEFTDIS GT MAXLEFT) THEN LEFTDIS = MAXLEFT
   ENDIF
;  ===========================================================
;  check if the position of the window is specified
   XSET = 0  
   YSET = 0
;
   IF ( KEYWORD_SET(XPOS) ) THEN BEGIN
      XARR(0) = XPOS
      XSET    = 1
   ENDIF
;
   IF ( KEYWORD_SET(YPOS) ) THEN BEGIN 
      YARR(0) = YPOS
      YSET    = 1
   ENDIF
;  ===========================================================
   LABEL_ERR,CHARSIZE,CORNER
   LABEL_LIM,XAXIS,YAXIS,X1,X2,Y1,Y2
   LABEL_SIDE,CORNER,XSIDE,YSIDE
;  ===========================================================
;  Main calculation
;
   IF (XAXIS EQ 0) THEN BEGIN
      XLIN,XSIDE,XSET,X1,X2,XRAT,SEGRAT,GAPRAT,LEFTDIS,XARR
   ENDIF ELSE BEGIN
      XLOG,XSIDE,XSET,X1,X2,XRAT,SEGRAT,GAPRAT,LEFTDIS,XARR
   ENDELSE
;
   IF (YAXIS EQ 0) THEN BEGIN
      YLIN,YSIDE,YSET,Y1,Y2,YRAT,DELRAT,NLABEL,YARR
   ENDIF ELSE BEGIN
      YLOG,YSIDE,YSET,Y1,Y2,YRAT,DELRAT,NLABEL,YARR
   ENDELSE
;  ===========================================================
   IF ( NOT KEYWORD_SET(CANCEL) ) THEN BEGIN
      I0 = 0
      IF ( KEYWORD_SET(HEADER) ) THEN BEGIN
         FOR I=0,HEADER-1 DO BEGIN
            XYOUTS,XARR(2),YARR(I),LABEL(I),SIZE=CHARSIZE
         ENDFOR
         I0 = HEADER
      ENDIF
;
;      IF ( KEYWORD_SET(LINETYPE) ) THEN BEGIN
;         NLINE = N_ELEMENTS(LINETYPE)
;         IF (NLINE NE NLABEL) THEN BEGIN
;            PRINT,' Fatal error in procedure LABELING!'
;            PRINT,' The array length of LABEL is different from', $
;                  ' the array length of LINETYPE.'
;            PRINT,' Program stopped.'
;            STOP
;         ENDIF
;      ENDIF
;
      FOR I = I0, NLABEL-1 DO BEGIN
         LINENUM = I MOD 6
         IF ( KEYWORD_SET(LINETYPE) ) THEN BEGIN
            LINENUM = LINETYPE(I)
         ENDIF
         IF ( KEYWORD_SET(PSYMTYPE) AND KEYWORD_SET(LINETYPE) ) THEN BEGIN
            OPLOT,[XARR(0),XARR(1)],[YARR(I),YARR(I)],LINE=LINENUM,$
                  COLOR=KOLOR(I)
            XTMP = [(XARR(0)+XARR(1))/2,(XARR(0)+XARR(1))/2]
            OPLOT,[XTMP(0),XTMP(1)],[YARR(I),YARR(I)],COLOR=KOLOR(I),$
                  PSYM=PSYMTYPE(I)
         ENDIF ELSE IF ( KEYWORD_SET(PSYMTYPE) ) THEN BEGIN
            XTMP = [(XARR(0)+XARR(1))/2,(XARR(0)+XARR(1))/2]
            OPLOT,[XTMP(0),XTMP(1)],[YARR(I),YARR(I)],COLOR=KOLOR(I),$
                  PSYM=PSYMTYPE(I)
         ENDIF ELSE BEGIN
            OPLOT,[XARR(0),XARR(1)],[YARR(I),YARR(I)],LINE=LINENUM,$
                  COLOR=KOLOR(I)
         ENDELSE
         XYOUTS,XARR(2),YARR(I),LABEL(I),SIZE=CHARSIZE
      ENDFOR  
   ENDIF
;
   RETURN 
   END
;**********************************************************************
   PRO LABEL_SIDE,CORNER,XSIDE,YSIDE
;**********************************************************************
;  Assign values to xside and yside.
;
;  xside = 0 --> labels are on the left  half of plot
;  xside = 1 --> labels are on the right half of plot
;  yside = 0 --> labels are on the upper half of plot
;  yside = 1 --> labels are on the lower half of plot
;
   CASE CORNER OF
   1: BEGIN
         XSIDE = 0
         YSIDE = 0
      END
   2: BEGIN
         XSIDE = 1
         YSIDE = 0
      END
   3: BEGIN
         XSIDE = 1
         YSIDE = 1
      END
   4: BEGIN
         XSIDE = 0
         YSIDE = 1
      END
   ENDCASE
;
   RETURN
   END
;**********************************************************************
   PRO LABEL_LIM,XAXIS,YAXIS,X1,X2,Y1,Y2
;**********************************************************************
;
;  Determine the axis scaling type
   XAXIS = FIX(!X.TYPE)
   YAXIS = FIX(!Y.TYPE)
;
;  Determine the boundaries
   X1 = !X.CRANGE(0)   &    X2 = !X.CRANGE(1)
   Y1 = !Y.CRANGE(0)   &    Y2 = !Y.CRANGE(1)
;
   IF (XAXIS EQ 1) THEN BEGIN
      X1 = 10.0^X1
      X2 = 10.0^X2
   ENDIF
;
   IF (YAXIS EQ 1) THEN BEGIN
      Y1 = 10.0^Y1
      Y2 = 10.0^Y2
   ENDIF
;
   RETURN
   END
;**********************************************************************
   PRO LABEL_ERR,CHARSIZE,CORNER
;**********************************************************************
;  Checks for erroneous inputs.
;
   CORNER = FIX(CORNER)
   IF ( (CORNER LT 1) OR (CORNER GT 4) ) THEN BEGIN
      PRINT,' Fatal error in calling procedure LABELING!'
      PRINT,' The parameter CORNER must be set to 1,2,3 or 4'
      PRINT,' The passed value of CORNER is',CORNER
      PRINT,' Program stopped.'
      STOP
   ENDIF
;
;  three plots on one page (special case)
   PMUL = !P.MULTI(2)
   IF ( PMUL GE 3 ) THEN BEGIN
      IF ( CHARSIZE GT 0.75 ) THEN BEGIN
         PRINT,' If you want to make three plots on one page', $
               ', make sure you use'
         PRINT,' a suitable charsize parameter in the call', $
               ' to procedure LABELING'
         MESSAGE,' The recommended charsize is 0.6 ', /INFORMATIONAL
      ENDIF
   ENDIF
;
   RETURN
   END
;**********************************************************************
   PRO XLIN,XSIDE,XSET,X1,X2,XRAT,SEGRAT,GAPRAT,LEFTDIS,XARR
;**********************************************************************
;  Calculates the necessary x position when x-axis is linear.
;
   XSIZE   = X2-X1
   XMARG   = XSIZE*XRAT
   SEG     = XSIZE*SEGRAT
   GAP     = SEG*GAPRAT
;
   IF (XSET EQ 1) THEN BEGIN 
      XARR(1) = XARR(0)+SEG
      XARR(2) = XARR(1)+GAP
   ENDIF ELSE BEGIN
      CASE XSIDE OF 
      0: BEGIN           
            XARR(0) = X1+XMARG 
            XARR(1) = XARR(0)+SEG
            XARR(2) = XARR(1)+GAP
         END
      1: BEGIN           
            XARR(0) = X2-XSIZE*LEFTDIS
            XARR(1) = XARR(0)+SEG
            XARR(2) = XARR(1)+GAP
         END
      ENDCASE
   ENDELSE
;
   RETURN
   END
;**********************************************************************
   PRO XLOG,XSIDE,XSET,X1,X2,XRAT,SEGRAT,GAPRAT,LEFTDIS,XARR
;**********************************************************************
;  Calculates the necessary x position when x-axis is logarithmic.
;
   XDEC    = FLOAT(FIX(ALOG10(ABS(X2/X1))+0.5)) 
                       ; number of decades on the x-axis
   XMARG   = XDEC*XRAT
   SEG     = XDEC*SEGRAT
   GAP     = SEG*GAPRAT
   LEFTDIS = XDEC*LEFTDIS
;
   IF (XSET EQ 1) THEN BEGIN  
      XARR(1) = XARR(0)*10^SEG
      XARR(2) = XARR(1)*10^GAP
   ENDIF ELSE BEGIN
      CASE XSIDE OF 
      0: BEGIN            
            XARR(0) = X1*10^XMARG 
            XARR(1) = XARR(0)*10^SEG
            XARR(2) = XARR(1)*10^GAP
         END
      1: BEGIN           
            XARR(0) = X2/10^LEFTDIS
            XARR(1) = XARR(0)*10^SEG
            XARR(2) = XARR(1)*10^GAP
         END
      ENDCASE
   ENDELSE
;
   RETURN
   END
;**********************************************************************
   PRO YLIN,YSIDE,YSET,Y1,Y2,YRAT,DELRAT,NLABEL,YARR
;**********************************************************************
;  Calculates the necessary y position when y-axis is linear.
;
   YSIZE   = Y2-Y1
   YMARG   = YSIZE*YRAT
   DEL     = YSIZE*DELRAT
;
   IF (YSET EQ 1) THEN BEGIN
      FOR I=1,NLABEL-1 DO YARR(I)=YARR(I-1)-DEL
   ENDIF ELSE BEGIN
      CASE YSIDE OF 
      0: BEGIN
            YARR(0) = Y2 - YMARG
            FOR I=1,NLABEL-1 DO YARR(I)=YARR(I-1)-DEL
         END
      1: BEGIN 
            YARR(0) = Y1+YMARG
            FOR I=1,NLABEL-1 DO YARR(I)=YARR(I-1)+DEL
            YARR = REVERSE(YARR)
         END
      ENDCASE
   ENDELSE
;
   RETURN
   END
;**********************************************************************
   PRO YLOG,YSIDE,YSET,Y1,Y2,YRAT,DELRAT,NLABEL,YARR
;**********************************************************************
;  Calculates the necessary y position when y-axis is logarithmic.
;
   YDEC    = FLOAT(FIX(ALOG10(ABS(Y2/Y1))+0.5)) 
                        ; number of decades on the y-axis
   YMARG   = YDEC*YRAT
   DEL     = YDEC*DELRAT
;
   IF (YSET EQ 1) THEN BEGIN
      FOR I=1,NLABEL-1 DO YARR(I)=YARR(I-1)/10^DEL
   ENDIF ELSE BEGIN
      CASE YSIDE OF 
      0: BEGIN    
            YARR(0) = Y2/10^YMARG
            FOR I=1,NLABEL-1 DO YARR(I)=YARR(I-1)/10^DEL
         END
      1: BEGIN    
            YARR(0) = Y1*10^YMARG
            FOR I=1,NLABEL-1 DO YARR(I)=YARR(I-1)*10^DEL
            YARR = REVERSE(YARR)
         END   
      ENDCASE
   ENDELSE
;
   RETURN
   END
