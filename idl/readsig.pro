;***********************************************************************
pro readsig,filename,nsig,signame,spec,th,npt,esig,sig
;***********************************************************************
;
line   = ''
name   = ''
nsig   = 100
negrid = 250
;
close,1
openr,1,filename
;
signame = strarr(nsig)
spec    = strarr(nsig)
th      = fltarr(nsig)
npt     = intarr(nsig)
esig    = fltarr(negrid,nsig)
sig     = fltarr(negrid,nsig)
;
r2 = fltarr(2)
r3 = fltarr(3)
;
w     = 0.0
scl   = 0.0
nesig = 0
done  = 0
isig  = -1

while (not eof(1)) do begin
   isig = isig + 1
   readf,1,line
   readf,1,name
   signame(isig) = strtrim(name,2)
   readf,1,line
   readf,1,name
   spec(isig) = strtrim(name,2)
   readf,1,w
   readf,1,scl
   readf,1,nesig
   if (nesig gt negrid) then begin
     print,'Increase number of energies in readsig to ',nesig
     stop
   endif else begin
     th(isig)   = w
     scale      = scl
     npt(isig)  = fix(nesig)
     readf,1,line
     x = fltarr(npt(isig))
     y = x
     readf,1,x
     readf,1,y
     esig(0:npt(isig)-1,isig) = x
     sig(0:npt(isig)-1,isig)  = y * scale
  endelse
endwhile
close,1
;
nsig = isig + 1
signame = signame(0:nsig-1)
spec    = spec(0:nsig-1)
th      = th(0:nsig-1)
npt     = npt(0:nsig-1)
esig    = esig(0:negrid-1,0:nsig-1)
sig     = sig(0:negrid-1,0:nsig-1)
;
return
end
