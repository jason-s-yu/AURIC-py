#!/bin/sh
env /opt/harris/envi54/idl/bin/idl << eof1
.compile laser.pro
.compile logtick.pro
.compile readint.pro
.compile select_file.pro
.run plot_int.pro
1
exit
eof1
