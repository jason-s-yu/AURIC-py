;
;
@laser
@labeling
@logtick
@loglim
;***********************************************************************
; main program
;***********************************************************************
;
path  = '/home/euler2/shen/auric/database/'
files = ['erates.sig','prates.sig','eloss.sig']
files = path + files
;
select_file,files,cho
filename = files(cho)
;
readsig,filename,nsig,signame,spec,e0,npt,esig,sig
;
!x.title = 'Energy (eV)'
!y.title = 'Cross Section (cm!u2!n)'
;
!x.range = [1e0,1e5]
!x.ticks = 5
!x.minor = 9
;
;
for i = 0, nsig-1 do begin
   !mtitle = signame(i)
;
   n = npt(i)
   x = esig(0:n-1,i)
   y = sig(0:n-1,i)
;
   loglim,y,y1,y2,ntick,maxdec=4
   !y.range = [y1,y2]
   !y.ticks = ntick
   !y.minor = 9
;
   logtick,'oo'
   plot_oo,x,y,psym=-4,symsize=0.7
;
   ans = ''
   print,' '
   read,'Send to laser printer? ',ans
   ans = strupcase(ans)
   if (ans eq 'Y') then begin
      laser
      plot_oo,x,y,psym=-4,symsize=0.7
      send
   endif
   unlogtick
endfor
;
end
;
