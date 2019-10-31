;
;*************************************************************
pro change_param,file,id,val
;***************************************************************
;
;  (in)   id ->string
;  (in)   val->float
;
;///////////////////////////////////////////////////////////////

  get_lun,lun
  openr,lun,file
  param = strarr(100)
  i = -1
  line = ' '
  while (not eof(lun)) do begin

    readf,lun,line
    i = i + 1
    param(i)=line
  endwhile
  close,lun
  free_lun
  param = param(0:i)
  for i = 0,n_elements(param)-1 do begin

    indx = strpos(strupcase(param(i)),strupcase(id))
    if (indx ge 0) then begin
      if( strlen( param(i) ) GT 24 ) then begin

        comment = strmid(param(i),24,strlen(param(i))-24)
      endif else begin

        comment = ''
      endelse
      param(i) = strmid( param(i), 0, 13 ) + $            ; original ID
        string( val, format = '(f11.2)' ) + $  ; new value
        comment

    endif
  endfor

  get_lun,lun
  openw,lun,file
  for i = 0,n_elements(param)-1 do begin

    printf, lun, param(i)
  endfor
  close,lun
  free_lun, lun

return
end
