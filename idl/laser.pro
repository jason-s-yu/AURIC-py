;
;
;///////////////////////////////////////////////////////////////////////
;   IDL procedures package "laser.pro"
;
;   Author:        M. Shen
;   Date written:  Aug. 1991
;   Version:       3.0
;
;   Purpose:
;      This package contains a set of utility subroutines which enable
;      the user to print plots to a laser printer. A number of
;      configuration options are present, including multiple plots on
;      one page, landscape printing, etc. This package raises the level
;      of abstraction of communication with the printing device.
;
;   Arguments:
;      All arguments/parameters are optional. They all have default values.
;      See below for detailed descriptions.
;
;   Usage:
;      - link this file to the user's plotting program. If this file
;        is on the IDL search path, one only has to `at' it by typing
;        @laser at the very beginning of the program.
;      - call procedure "laser" to set up the printer configuration.
;      - execute your plotting statements. (plot_io, plot_oo...)
;      - call procedure "send" which closes the device file and, upon
;
;          sample program
;          ---------------------------------------------------------- 
;          ; program sample
;            @laser
;          ; put three plots on one page, in wide format.
;            laser,ppg=3,fontsize=15,/wide
;              plot,x1,y1,line=0
;              plot_io,x2,y2,line=0
;              oplot,x2p,y2p,line=1
;              plot_oo,x3,y3,line=0
;            send
;            end  ; of program sample
;          ---------------------------------------------------------- 
;
;   Common blocks:
;      dnameblk (it retains the device name and the filename)
;
;   Side effects:
;      - This package does not like SET_VIEWPORT statements, so do not
;        use them.
;      - This package modifies the following environment variables:
;        !P.FONT, !P.MULTI, DEVICE settings, but it returns them to
;        IDL default settings.
;
;   Modification history:
;      3/12/1997: (JSE). Added FILENAME keyword to laser procedure.
;                 Added variable FNAME to COMMON dnameblk to hold FILENAME.
;                 Added variable FFORMAT to COMMON dnameblk to hold FILEFORMAT.
;      3/8/1994 : by M. Shen. Renamed from "sunlaser.pro" to "laser.pro".
;                 consolidated procedures "one", "two",... to procedure
;                "laser" for better maintainability.
;      12/9/1991: by M. Shen. A switch of font size was added.
;
;***********************************************************************
   PRO LASER,PPG        = PPG,         $
             FILEFORMAT = FILEFORMAT,  $
             FILENAME   = FILENAME,    $
             FONTSIZE   = FONTSIZE,    $
             WIDE       = WIDE,        $
             LANDSCAPE  = LANDSCAPE,   $
             VECTORFONT = VECTORFONT
;***********************************************************************
;  Purpose:
;     Configure the printing device to accept IDL plots.
;
;  Arguments:
;     (in) PPG        = plots per page, default is one. Its limits are:
;                       for portrait:  1 to 8.
;                       for landscape: 1 to 4.
;     (in) FILEFORMAT = plot format, it must be one of the following:
;                       "PS"  (PostScript) is default,
;                       "EPS" (Encapsulated PostScript),
;                       "CGM" (Computer Graphics Metafile)
;     (in) FONTSIZE   = font size. Default is 12.
;     (in) WIDE       = when this switch is set, the plots will be stretched
;                       horizontally to fit the page width.
;     (in) LANDSCAPE  = when this switch is set, the printer will print
;                       in the landscape orientation.
;     (in) VECTORFONT = indicates vector-drawn fonts will be used. When
;                       this switch is set, the system variable !P.FONT
;                       will be set to -1. The default is PostScript font,
;                       which sets !P.FONT = 0.
;
;  Local identifiers:
;     DNAME     = user's current device name.
;     LANDPLOT  = a flag that indicates whether the LANDSCAPE option
;                 is set.
;     PFONT     = not sure.
;     SETFORMAT = format name to be fed to the SET_PLOT procedure.
;     WIDEPLOT  = a flag that indicates whether the WIDE option is set.
;///////////////////////////////////////////////////////////////////////
   COMMON DNAMEBLK,DNAME,FNAME,FFORMAT
;  ---------------------------------------------------------------------
;  save the current device name.
;
   DNAME = !D.NAME
;  ---------------------------------------------------------------------
;  set default parameter values.
;
   IF ( NOT KEYWORD_SET(PPG) ) THEN BEGIN
      PPG = 1
   ENDIF
;
   IF ( NOT KEYWORD_SET(FONTSIZE) ) THEN BEGIN
      FONTSIZE = 12
   ENDIF
;
   IF ( NOT KEYWORD_SET(FILEFORMAT) ) THEN BEGIN
      FILEFORMAT = 'PS'
   ENDIF
   FFORMAT = FILEFORMAT
;
   PRINT,' '
   PRINT,' Plot to file in ',FILEFORMAT,' format.'
   PRINT,' '
;
   IF ( NOT KEYWORD_SET(WIDE) ) THEN BEGIN
      WIDEPLOT = 0
   ENDIF ELSE BEGIN
      WIDEPLOT = 1
   ENDELSE
;
   IF ( NOT KEYWORD_SET(LANDSCAPE) ) THEN BEGIN
      LANDPLOT = 0
   ENDIF ELSE BEGIN
      LANDPLOT = 1
   ENDELSE
;
   IF ( NOT KEYWORD_SET(VECTORFONT) ) THEN BEGIN
      PFONT = 0
   ENDIF ELSE BEGIN
      PFONT = -1
   ENDELSE
;  ---------------------------------------------------------------------
;  start to configure the printing device.
;
   FILEFORMAT = STRUPCASE(FILEFORMAT)
   CASE FILEFORMAT OF
      'PS' : SETFORMAT = 'PS'
      'EPS': SETFORMAT = 'PS'       ; this statement is correct.
;     CGM is disabled because I can't get it to work. M. Shen
      'CGM': BEGIN
;                SETFORMAT = 'CGM'
                PRINT,''
                PRINT,' Sorry, procedure LASER currently does not' + $
                      ' support the CGM format.'
                STOP
             END
      ELSE: BEGIN
               PRINT,' '
               PRINT,' Error: fileformat = ',FILEFORMAT,' is not supported.'
               STOP
            END
   ENDCASE
;
   SET_PLOT,SETFORMAT
   !P.FONT = PFONT
;  ---------------------------------------------------------------------
;  given the plots per page, set the parameters which define the printing
;  regions.
;
   CASE 1 OF
;     -----------------------------------
      (PPG EQ 1): BEGIN
         !P.MULTI = [0,1,1,0,0]
;
;        the wide option is ignored here.
;
         IF (LANDPLOT EQ 0) THEN BEGIN
;           portrait plot
;
            XSIZE   = 7.0
            YSIZE   = 5.0
            XOFFSET = 0.8
            YOFFSET = 5.0
         ENDIF ELSE BEGIN
;           landscape plot
;
            XSIZE   = 9.0
            YSIZE   = 6.5
            XOFFSET = 1.0
            YOFFSET = 10.0
         ENDELSE
      END
;     -----------------------------------
      (PPG EQ 2): BEGIN
         !P.MULTI = [0,1,2,0,0]
;
;        both the wide and landscape options are ignored here.
;
         XSIZE   = 6.5
         YSIZE   = 8.9
         XOFFSET = 0.8
         YOFFSET = 0.9
      END
;     -----------------------------------
      (PPG EQ 3): BEGIN
         !P.MULTI = [0,1,3,0,0]
;
;        the landscape option is ignored here.
;
         IF (WIDEPLOT EQ 0) THEN BEGIN
;           plot in normal golden rectangle
;
            XSIZE   = 4.5
            YSIZE   = 9.0
            XOFFSET = 1.8
            YOFFSET = 1.0
         ENDIF ELSE BEGIN
;           plot in wide format
;
            XSIZE   = 6.3
            YSIZE   = 9.0
            XOFFSET = 0.9
            YOFFSET = 1.0
         ENDELSE
      END
;     -----------------------------------
      (PPG EQ 4): BEGIN
         !P.MULTI = [0,2,2,0,0]
;
;        the wide option is ignored here.
;
         IF (LANDPLOT EQ 0) THEN BEGIN
;           portrait plot
;
            XSIZE   = 8.0
            YSIZE   = 6.3
            XOFFSET = 0.3
            YOFFSET = 4.2
         ENDIF ELSE BEGIN
;           landscape plot
;
            XSIZE   = 9.0
            YSIZE   = 6.8
            XOFFSET = 0.7
            YOFFSET = 10.2
         ENDELSE
      END
;     -----------------------------------
      (PPG EQ 5 OR PPG EQ 6): BEGIN
         !P.MULTI = [0,2,3,0,0]
;
;        both the wide and landscape options are ignored here.
;
         XSIZE   = 7.8
         YSIZE   = 9.0
         XOFFSET = 0.4
         YOFFSET = 0.95
      END
;     -----------------------------------
      ELSE: BEGIN
         PRINT,' '
         PRINT,' Error! Plots per page (PPG) = ',PPG, $
               ' is not allowed. It must be less than 6.'
         STOP
      ENDELSE
;     -----------------------------------
   ENDCASE
;  ---------------------------------------------------------------------
;  configure the printing device.
;
   FNAME = 'idl.ps'
   IF (KEYWORD_SET(FILENAME)) THEN FNAME=FILENAME
;
   DEVICE,FILENAME=FNAME
;
   IF (FILEFORMAT EQ 'EPS') THEN BEGIN
      DEVICE,/ENCAPSULATED,/PREVIEW
   ENDIF
;
   IF (LANDPLOT EQ 0) THEN BEGIN
      DEVICE,/PORTRAIT
   ENDIF ELSE BEGIN
      DEVICE,/LANDSCAPE
   ENDELSE
;
   DEVICE,FONT_SIZE=FONTSIZE,/TIMES
   DEVICE,/INCHES,XSIZE=XSIZE,YSIZE=YSIZE,XOFFSET=XOFFSET,YOFFSET=YOFFSET
;  ---------------------------------------------------------------------
   RETURN
   END
;***********************************************************************
   PRO SEND,COMMAND=COMMAND
;***********************************************************************
;  Purpose:
;     Close the printing device and send plots to the printer queue.
;
;  Arguments:
;     (in) command  = command that send the plots to the printer queue.
;                     See below for its default value.
;     (in) filename = name of output file.
;///////////////////////////////////////////////////////////////////////
   COMMON DNAMEBLK,DNAME,FNAME,FFORMAT
;
   IF ( NOT KEYWORD_SET(COMMAND) ) THEN COMMAND = 'lpr '+FNAME
;
   DEVICE,/CLOSE_FILE
   IF (STRTRIM(STRUPCASE(FFORMAT),2) EQ 'PS') THEN SPAWN,COMMAND
   SET_PLOT,DNAME
   !P.FONT  = -1
   !P.MULTI = [0,0,0,0,0]
;
   RETURN
   END

