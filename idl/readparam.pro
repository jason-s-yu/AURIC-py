function readparam,file,label

  line = ' '

  close,1
  openr,1,file
  while (not eof(1)) do begin
    readf,1,line
    indx = strpos(line,label)
    if (indx ge 0) then begin
      value = strmid(line,0,indx)
      indx_dec = strpos(value,'.')
      if (indx_dec ge 0) then begin
        close,1
        return,float(value)
      endif else begin
        close,1
        return,long(value)
      endelse
    endif
  endwhile
  close,1
  print,' '
  print,'Cannot find ',strtrim(label,2),' in file ',file
  print,' '
  stop

return,''
end
