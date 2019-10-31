import matplotlib.pyplot as plt

import xarray as xr
from dask.diagnostics import ProgressBar

import numpy as np

wavelengths = [
    11.00, 13.00, 15.00, 17.00, 18.62, 18.97, 21.60, 21.80, 22.10, 28.47, 28.79, 29.52, 30.02, 30.43, 33.74, 40.95, 43.76, 44.02, 44.16, 45.66, 46.40, 46.67, 47.87, 49.22, 50.52, 50.69, 52.30, 52.91, 54.15, 54.42, 55.06, 55.34, 56.08, 56.92, 57.36, 57.56, 57.88, 58.96, 59.62, 60.30, 60.85, 61.07, 61.63, 61.90, 62.30, 62.35, 62.77, 63.16, 63.30, 63.65, 64.11, 64.60, 65.21, 65.71, 65.85, 66.26, 66.30, 66.37, 67.14, 67.35, 68.35, 69.65, 70.00, 70.54, 70.75, 71.00, 71.94, 72.31, 72.63, 72.80, 72.95, 73.47, 73.55, 74.21, 74.44, 74.83, 75.03, 75.29, 75.46, 75.73, 76.01, 76.48, 76.83, 76.94, 77.30, 77.74, 78.56, 78.70, 79.08, 79.48, 79.76, 80.00, 80.55, 82.43, 82.74, 82.84, 83.42, 83.67, 84.00, 86.77, 86.86, 86.98, 87.30, 87.61, 88.09, 88.11, 88.14, 88.42, 88.64, 88.90, 89.14, 89.70, 90.14, 90.45, 90.71, 91.00, 91.48, 91.69, 91.81, 92.09, 92.81, 93.61, 94.07, 94.25, 94.39, 94.90, 95.37, 95.51, 95.81, 96.05, 96.49, 96.83, 97.12, 97.51, 97.87, 98.12, 98.26, 98.50, 99.71, 99.99, 100.54, 103.01, 103.15, 103.58, 103.94, 105.23, 106.25, 108.05, 109.98, 110.56, 110.62, 110.76, 111.16, 111.25, 113.80, 114.09, 114.24, 115.39, 115.82, 116.75, 117.20, 120.40, 121.15, 121.79, 122.70, 123.50, 127.65, 129.87, 130.30, 131.02, 131.21, 136.21, 136.28, 136.34, 136.45, 136.48, 141.20, 144.27, 145.04, 148.40, 150.10, 152.15, 154.18, 157.73, 158.37, 159.98, 160.37, 162.00, 164.15, 167.50, 168.17, 168.55, 168.92, 169.70, 171.08, 172.17, 173.08, 174.58, 175.26, 177.24, 178.05, 179.27, 179.75, 180.41, 181.14, 182.17, 183.45, 184.53, 184.80, 185.21, 186.60, 186.87, 187.95, 188.23, 188.31, 190.02, 191.04, 191.34, 192.40, 192.82, 193.52, 195.13, 196.52, 196.65, 197.44, 198.58, 200.02, 201.13, 202.05, 202.64, 203.81, 204.25, 204.94, 206.26, 206.38, 207.46, 208.33, 209.63, 209.78, 211.32, 212.14, 213.78, 214.75, 215.16, 216.88, 218.19, 219.13, 220.08, 221.44, 221.82, 224.74, 225.12, 227.01, 227.19, 227.47, 228.70, 230.65, 231.55, 232.60, 233.84, 234.38, 237.12, 237.20, 237.33, 239.87, 240.71, 241.74, 243.03, 243.78, 244.92, 245.94, 246.21, 246.91, 247.18, 249.18, 251.10, 251.95, 252.19, 253.78, 256.32, 256.38, 256.64, 256.92, 257.16, 257.39, 258.36, 259.52, 261.05, 262.99, 264.24, 264.80, 270.51, 271.99, 272.64, 274.19, 275.35, 275.67, 276.15, 276.84, 277.00, 277.27, 278.40, 281.41, 284.15, 285.70, 289.17, 290.69, 291.70, 292.78, 296.19, 299.50, 303.31, 303.78, 315.02, 316.20, 319.01, 319.83, 320.56, 335.41, 345.13, 345.74, 347.39, 349.85, 356.01, 360.80, 364.48, 368.07, 399.82, 401.14, 401.94, 403.26, 417.24, 430.47, 436.70, 453.00, 454.00, 455.00, 456.00, 457.00, 458.00, 459.00, 460.00, 461.00, 462.00, 463.00, 464.00, 465.00, 465.22, 466.00, 467.00, 468.00, 469.00, 470.00, 471.00, 472.00, 473.00, 474.00, 475.00, 476.00, 477.00, 478.00, 479.00, 480.00, 481.00, 482.00, 483.00, 484.00, 485.00, 486.00, 487.00, 488.00, 489.00, 489.50, 490.00, 491.00, 492.00, 493.00, 494.00, 495.00, 496.00, 497.00, 498.00, 499.00, 499.37, 500.00, 501.00, 502.00, 503.00, 504.00, 507.93, 515.60, 520.66, 525.80, 537.02, 542.80, 550.00, 554.37, 558.60, 562.80, 568.50, 572.30, 580.40, 584.33, 592.40, 599.60, 609.76, 616.60, 624.93, 629.73, 638.50, 640.41, 640.93, 641.81, 644.10, 650.30, 657.30, 661.40, 671.50, 681.70, 685.71, 690.80, 694.30, 700.00, 701.00, 702.00, 703.00, 703.36, 704.00, 705.00, 706.00, 707.00, 708.00, 709.00, 710.00, 711.00, 712.00, 712.70, 713.00, 714.00, 715.00, 716.00, 717.00, 718.00, 718.50, 719.00, 720.00, 721.00, 722.00, 723.00, 724.00, 725.00, 726.00, 727.00, 728.00, 729.00, 730.00, 731.00, 732.00, 733.00, 734.00, 735.00, 736.00, 737.00, 738.00, 739.00, 740.00, 741.00, 742.00, 743.00, 744.00, 745.00, 746.00, 747.00, 748.00, 749.00, 750.00, 750.01, 751.00, 752.00, 753.00, 754.00, 755.00, 756.00, 757.00, 758.00, 758.68, 759.00, 759.44, 760.00, 760.30, 761.00, 761.13, 762.00, 762.01, 763.00, 764.00, 765.00, 765.15, 766.00, 767.00, 768.00, 769.00, 770.00, 770.41, 771.00, 772.00, 773.00, 774.00, 775.00, 776.00, 776.01, 777.00, 778.00, 779.00, 780.00, 780.32, 781.00, 782.00, 783.00, 784.00, 785.00, 786.00, 786.47, 787.00, 787.71, 788.00, 789.00, 790.00, 790.15, 791.00, 792.00, 793.00, 794.00, 795.00, 796.00, 797.00, 798.00, 799.00, 800.00, 801.00, 802.00, 803.00, 804.00, 805.00, 806.00, 807.00, 808.00, 809.00, 810.00, 811.00, 812.00, 813.00, 814.00, 815.00, 816.00, 817.00, 818.00, 819.00, 820.00, 821.00, 822.00, 823.00, 824.00, 825.00, 826.00, 827.00, 828.00, 829.00, 830.00, 831.00, 832.00, 833.00, 834.00, 834.20, 835.00, 836.00, 837.00, 838.00, 839.00, 840.00, 841.00, 842.00, 843.00, 844.00, 845.00, 846.00, 847.00, 848.00, 849.00, 850.00, 851.00, 852.00, 853.00, 854.00, 855.00, 856.00, 857.00, 858.00, 859.00, 860.00, 861.00, 862.00, 863.00, 864.00, 865.00, 866.00, 867.00, 868.00, 869.00, 870.00, 871.00, 872.00, 873.00, 874.00, 875.00, 876.00, 877.00, 878.00, 879.00, 880.00, 881.00, 882.00, 883.00, 884.00, 885.00, 886.00, 887.00, 888.00, 889.00, 890.00, 891.00, 892.00, 893.00, 894.00, 895.00, 896.00, 897.00, 898.00, 899.00, 900.00, 901.00, 902.00, 903.00, 904.00, 904.10, 905.00, 906.00, 907.00, 908.00, 909.00, 910.00, 911.00, 912.00, 913.00, 913.99, 914.00, 914.99, 915.00, 915.99, 916.00, 916.99, 917.00, 918.00, 918.99, 919.00, 920.00, 920.96, 921.00, 922.00, 923.00, 923.15, 924.00, 925.00, 926.00, 926.20, 927.00, 928.00, 929.00, 930.00, 930.75, 931.00, 932.00, 933.00, 933.38, 934.00, 935.00, 936.00, 937.00, 937.80, 938.00, 939.00, 940.00, 941.00, 942.00, 943.00, 944.00, 944.52, 945.00, 946.00, 947.00, 948.00, 949.00, 949.74, 950.00, 951.00, 952.00, 953.00, 954.00, 955.00, 956.00, 957.00, 958.00, 959.00, 960.00, 961.00, 962.00, 963.00, 964.00, 965.00, 966.00, 967.00, 968.00, 969.00, 970.00, 971.00, 972.00, 972.54, 973.00, 974.00, 975.00, 976.00, 977.00, 977.02, 978.00, 979.00, 980.00, 981.00, 982.00, 983.00, 984.00, 985.00, 986.00, 987.00, 988.00, 989.00, 989.79, 990.00, 991.00, 991.55, 992.00, 993.00, 994.00, 995.00, 996.00, 997.00, 998.00, 999.00, 1000.00, 1001.00, 1002.00, 1003.00, 1004.00, 1005.00, 1006.00, 1007.00, 1008.00, 1009.00, 1010.00, 1010.20, 1011.00, 1012.00, 1013.00, 1014.00, 1015.00, 1016.00, 1017.00, 1018.00, 1019.00, 1020.00, 1021.00, 1022.00, 1023.00, 1024.00, 1025.00, 1025.72, 1026.00, 1027.00, 1028.00, 1029.00, 1030.00, 1031.00, 1031.91, 1032.00, 1033.00, 1034.00, 1035.00, 1036.00, 1036.34, 1037.00, 1037.02, 1037.61, 1038.00, 1039.00, 1040.00, 1041.00, 1042.00, 1043.00, 1044.00, 1045.00, 1046.00, 1047.00, 1048.00, 1049.00, 1050.00
]

hinteregger_flux = [
    2.381E+06, 3.259E+06, 7.896E+06, 5.389E+06, 1.253E+06, 4.137E+06, 3.760E+06, 1.253E+06, 3.760E+06, 5.690E+06, 1.692E+07, 1.489E+07, 1.991E+06, 8.212E+06, 1.252E+07, 5.790E+06, 1.058E+07, 7.720E+06, 8.685E+06, 4.825E+06, 1.360E+07, 8.850E+06, 9.956E+06, 2.166E+07, 1.690E+07, 1.690E+07, 1.763E+07, 2.453E+06, 1.814E+07, 7.965E+06, 6.547E+06, 2.527E+07, 5.168E+06, 1.637E+07, 1.372E+07, 1.106E+07, 1.125E+07, 6.756E+06, 6.756E+06, 5.531E+06, 7.965E+06, 1.108E+07, 5.539E+06, 1.106E+07, 2.269E+05, 4.298E+06, 5.565E+06, 8.630E+06, 1.412E+07, 9.071E+06, 6.689E+06, 5.531E+06, 6.638E+06, 9.071E+06, 7.846E+06, 1.760E+07, 1.485E+07, 2.347E+07, 4.910E+06, 7.814E+06, 5.089E+06, 3.053E+07, 2.453E+06, 7.301E+06, 6.638E+06, 9.735E+06, 1.158E+07, 1.416E+07, 4.037E+06, 4.646E+06, 7.523E+06, 1.226E+07, 4.311E+06, 5.531E+06, 2.876E+06, 8.850E+06, 7.157E+06, 5.531E+06, 8.408E+06, 5.531E+06, 1.946E+07, 6.081E+06, 9.071E+06, 7.301E+06, 6.416E+06, 6.383E+06, 6.638E+06, 6.837E+06, 4.204E+06, 7.033E+06, 5.089E+06, 5.470E+06, 8.986E+06, 8.152E+06, 1.016E+07, 1.016E+07, 6.773E+06, 5.720E+06, 7.676E+06, 1.161E+07, 3.302E+06, 7.821E+06, 5.310E+06, 4.425E+06, 1.021E+07, 1.350E+07, 2.269E+05, 4.204E+06, 5.310E+06, 9.587E+06, 6.812E+06, 7.569E+06, 7.821E+06, 5.046E+06, 6.638E+06, 8.629E+06, 4.204E+06, 9.386E+06, 1.062E+07, 8.408E+06, 8.408E+06, 1.239E+07, 1.572E+07, 1.727E+05, 3.761E+06, 1.727E+05, 9.204E+06, 6.416E+06, 6.416E+06, 1.572E+07, 4.204E+06, 5.177E+06, 9.971E+06, 6.638E+06, 4.410E+06, 6.125E+06, 6.125E+06, 5.753E+06, 4.425E+06, 5.974E+06, 1.859E+07, 3.403E+06, 1.727E+05, 1.015E+07, 1.350E+07, 8.485E+06, 3.453E+06, 2.409E+06, 1.727E+05, 1.727E+05, 1.727E+05, 3.319E+06, 1.703E+05, 1.062E+07, 6.638E+06, 5.753E+06, 1.703E+05, 1.727E+05, 5.310E+06, 8.629E+06, 5.753E+06, 1.727E+05, 1.703E+05, 2.434E+06, 6.981E+06, 5.753E+06, 9.956E+06, 8.571E+06, 1.703E+05, 1.151E+07, 1.062E+07, 1.703E+05, 1.703E+05, 1.703E+05, 1.703E+05, 1.703E+05, 2.500E+07, 1.912E+06, 2.451E+07, 7.179E+07, 1.916E+07, 6.598E+07, 3.475E+07, 4.910E+07, 2.468E+07, 2.260E+07, 2.434E+07, 1.217E+07, 4.637E+07, 3.132E+07, 5.783E+07, 3.293E+07, 2.024E+07, 5.177E+07, 5.116E+08, 1.894E+07, 4.735E+07, 5.154E+08, 7.324E+07, 3.116E+08, 5.172E+07, 7.320E+06, 5.197E+07, 4.516E+08, 5.349E+07, 5.828E+07, 1.448E+07, 8.398E+07, 5.803E+06, 2.923E+07, 3.088E+07, 6.306E+07, 1.685E+07, 3.790E+07, 3.028E+08, 8.111E+07, 4.102E+07, 5.473E+07, 1.563E+08, 1.483E+08, 2.559E+08, 4.180E+08, 5.899E+07, 1.133E+07, 2.432E+07, 2.774E+07, 9.122E+07, 1.551E+08, 2.402E+08, 4.890E+07, 1.186E+08, 4.378E+07, 2.980E+07, 3.319E+06, 3.319E+06, 3.319E+06, 4.395E+06, 5.473E+06, 2.434E+06, 2.644E+08, 4.029E+07, 1.520E+07, 8.218E+06, 7.303E+07, 1.911E+07, 9.318E+07, 6.949E+07, 9.940E+07, 8.965E+07, 5.473E+06, 7.777E+07, 1.693E+08, 7.979E+07, 4.906E+06, 1.146E+08, 4.393E+07, 2.088E+07, 2.538E+07, 3.694E+07, 8.830E+07, 7.324E+07, 1.524E+07, 1.750E+07, 2.973E+07, 5.460E+07, 1.016E+08, 1.487E+08, 1.340E+08, 1.398E+08, 9.649E+07, 2.213E+06, 1.386E+08, 2.589E+07, 5.509E+07, 6.348E+07, 4.693E+07, 1.386E+08, 1.544E+08, 4.980E+07, 3.620E+08, 1.096E+08, 1.188E+08, 6.132E+07, 1.604E+08, 1.727E+08, 2.566E+08, 8.839E+07, 1.268E+08, 1.173E+08, 7.618E+07, 2.895E+08, 2.413E+08, 1.376E+08, 1.590E+07, 4.825E+08, 3.886E+07, 3.235E+07, 9.182E+06, 1.659E+07, 6.638E+06, 1.394E+08, 3.627E+07, 2.867E+07, 2.453E+09, 3.931E+07, 1.139E+08, 7.152E+07, 4.095E+07, 1.049E+08, 1.192E+08, 4.382E+07, 1.861E+09, 9.243E+09, 2.077E+08, 2.150E+08, 3.203E+08, 2.796E+08, 3.028E+08, 1.995E+09, 2.296E+08, 1.611E+08, 4.256E+08, 2.296E+08, 3.121E+08, 1.027E+09, 2.954E+08, 1.210E+09, 2.656E+07, 5.874E+07, 1.553E+08, 9.092E+07, 2.159E+08, 1.281E+08, 1.904E+08, 2.876E+06, 2.876E+06, 2.876E+06, 2.876E+06, 2.876E+06, 2.876E+06, 2.876E+06, 3.540E+06, 3.540E+06, 3.540E+06, 3.540E+06, 3.540E+06, 4.425E+06, 3.108E+08, 4.425E+06, 4.425E+06, 5.531E+06, 5.531E+06, 5.531E+06, 5.531E+06, 6.416E+06, 6.416E+06, 7.301E+06, 7.301E+06, 7.301E+06, 8.408E+06, 8.408E+06, 9.071E+06, 9.071E+06, 9.956E+06, 9.956E+06, 1.106E+07, 1.195E+07, 1.195E+07, 1.283E+07, 1.350E+07, 1.460E+07, 1.460E+07, 1.624E+07, 1.549E+07, 1.637E+07, 1.748E+07, 1.836E+07, 1.903E+07, 2.102E+07, 2.190E+07, 2.301E+07, 2.390E+07, 2.544E+07, 7.479E+08, 2.655E+07, 2.810E+07, 2.943E+07, 3.098E+07, 3.297E+07, 1.229E+08, 6.923E+07, 3.435E+08, 1.214E+08, 3.844E+08, 3.438E+07, 4.289E+07, 1.336E+09, 1.047E+08, 1.395E+08, 1.144E+08, 1.524E+08, 1.783E+07, 3.861E+09, 4.248E+07, 3.052E+08, 1.177E+09, 2.682E+07, 2.904E+08, 2.537E+09, 5.509E+07, 9.477E+06, 1.124E+07, 1.478E+07, 1.751E+07, 3.452E+07, 9.959E+06, 9.959E+06, 1.831E+07, 5.757E+07, 1.787E+08, 4.624E+07, 3.433E+07, 2.461E+06, 2.461E+06, 2.461E+06, 2.707E+06, 6.289E+08, 2.707E+06, 2.707E+06, 2.707E+06, 2.707E+06, 2.707E+06, 2.707E+06, 3.199E+06, 3.199E+06, 3.199E+06, 2.142E+07, 3.445E+06, 3.445E+06, 3.691E+06, 3.691E+06, 3.691E+06, 4.184E+06, 8.529E+07, 4.184E+06, 4.184E+06, 4.184E+06, 4.430E+06, 4.430E+06, 4.676E+06, 4.676E+06, 4.676E+06, 4.676E+06, 4.922E+06, 4.922E+06, 5.414E+06, 5.414E+06, 5.414E+06, 5.660E+06, 5.906E+06, 5.906E+06, 6.152E+06, 6.152E+06, 6.644E+06, 6.644E+06, 6.644E+06, 6.891E+06, 7.137E+06, 7.137E+06, 7.383E+06, 7.383E+06, 7.875E+06, 8.121E+06, 8.367E+06, 8.367E+06, 8.613E+06, 8.961E+07, 9.105E+06, 9.105E+06, 9.351E+06, 9.597E+06, 9.597E+06, 1.009E+07, 1.034E+07, 1.058E+07, 5.902E+07, 1.132E+07, 4.515E+07, 1.132E+07, 1.573E+08, 1.157E+07, 3.923E+07, 1.181E+07, 5.902E+07, 1.206E+07, 1.255E+07, 1.280E+07, 3.692E+08, 1.304E+07, 1.329E+07, 1.378E+07, 1.403E+07, 1.427E+07, 5.502E+08, 1.501E+07, 1.526E+07, 1.550E+07, 1.624E+07, 1.624E+07, 2.038E+07, 1.673E+07, 1.747E+07, 1.772E+07, 1.796E+07, 1.870E+07, 2.963E+08, 1.895E+07, 1.969E+07, 1.993E+07, 2.043E+07, 2.116E+07, 2.141E+07, 2.350E+08, 2.239E+07, 4.640E+08, 2.264E+07, 2.338E+07, 2.362E+07, 7.981E+08, 2.461E+07, 2.510E+07, 2.535E+07, 2.633E+07, 2.707E+07, 2.756E+07, 2.830E+07, 2.928E+07, 2.978E+07, 3.052E+07, 3.175E+07, 3.224E+07, 3.322E+07, 3.421E+07, 3.470E+07, 3.568E+07, 3.667E+07, 3.765E+07, 3.839E+07, 3.937E+07, 4.060E+07, 4.159E+07, 4.257E+07, 4.380E+07, 4.503E+07, 4.577E+07, 4.700E+07, 4.799E+07, 4.971E+07, 5.045E+07, 5.217E+07, 5.340E+07, 5.488E+07, 5.635E+07, 5.758E+07, 5.906E+07, 6.078E+07, 6.201E+07, 6.374E+07, 6.546E+07, 6.694E+07, 6.866E+07, 7.063E+07, 7.210E+07, 1.071E+09, 7.432E+07, 7.580E+07, 7.776E+07, 7.973E+07, 8.195E+07, 8.392E+07, 8.638E+07, 8.810E+07, 9.056E+07, 9.278E+07, 9.524E+07, 9.770E+07, 1.002E+08, 1.026E+08, 1.051E+08, 1.078E+08, 1.107E+08, 1.134E+08, 1.166E+08, 1.194E+08, 1.223E+08, 1.255E+08, 1.290E+08, 1.319E+08, 1.353E+08, 1.388E+08, 1.425E+08, 1.457E+08, 1.494E+08, 1.531E+08, 1.573E+08, 1.612E+08, 1.651E+08, 1.696E+08, 1.737E+08, 1.782E+08, 1.826E+08, 1.873E+08, 1.922E+08, 1.971E+08, 2.020E+08, 2.070E+08, 2.121E+08, 2.178E+08, 2.232E+08, 2.289E+08, 2.348E+08, 2.409E+08, 2.471E+08, 2.532E+08, 2.596E+08, 2.660E+08, 2.727E+08, 2.798E+08, 2.869E+08, 2.943E+08, 3.017E+08, 3.093E+08, 3.170E+08, 3.251E+08, 3.332E+08, 3.418E+08, 3.504E+08, 3.590E+08, 3.684E+08, 3.777E+08, 3.873E+08, 3.972E+08, 4.073E+08, 4.176E+08, 2.019E+08, 4.282E+08, 4.388E+08, 4.501E+08, 4.617E+08, 4.732E+08, 4.853E+08, 4.973E+08, 5.101E+08, 4.146E+06, 3.429E+08, 4.146E+06, 2.876E+08, 4.146E+06, 2.544E+08, 4.319E+06, 2.213E+08, 4.319E+06, 4.664E+06, 2.213E+08, 4.664E+06, 4.837E+06, 2.830E+08, 4.837E+06, 4.837E+06, 5.183E+06, 2.953E+08, 5.183E+06, 5.355E+06, 5.355E+06, 3.076E+08, 5.528E+06, 5.528E+06, 5.701E+06, 5.701E+06, 3.199E+08, 5.874E+06, 5.874E+06, 6.046E+06, 1.693E+08, 6.046E+06, 6.219E+06, 6.219E+06, 6.392E+06, 4.676E+08, 6.565E+06, 6.565E+06, 6.737E+06, 6.737E+06, 7.083E+06, 7.428E+06, 7.428E+06, 1.123E+08, 7.601E+06, 7.774E+06, 7.774E+06, 7.947E+06, 8.119E+06, 8.613E+08, 8.119E+06, 8.292E+06, 8.465E+06, 8.638E+06, 8.644E+06, 8.810E+06, 9.156E+06, 9.329E+06, 9.501E+06, 9.674E+06, 9.674E+06, 9.847E+06, 1.002E+07, 1.019E+07, 1.054E+07, 1.071E+07, 1.088E+07, 1.123E+07, 1.140E+07, 1.157E+07, 1.175E+07, 1.192E+07, 1.209E+07, 2.028E+09, 1.227E+07, 1.244E+07, 1.278E+07, 1.313E+07, 1.347E+07, 1.125E+10, 1.365E+07, 1.382E+07, 1.417E+07, 1.434E+07, 1.451E+07, 1.468E+07, 1.520E+07, 1.538E+07, 1.555E+07, 1.589E+07, 1.607E+07, 1.658E+07, 3.375E+08, 1.676E+07, 1.728E+07, 6.748E+08, 1.745E+07, 1.779E+07, 1.797E+07, 1.831E+07, 1.866E+07, 1.883E+07, 1.952E+07, 1.987E+07, 2.021E+07, 2.038E+07, 2.073E+07, 2.125E+07, 2.159E+07, 2.211E+07, 2.246E+07, 2.280E+07, 2.332E+07, 2.367E+07, 2.401E+07, 1.468E+08, 2.436E+07, 2.488E+07, 2.557E+07, 2.591E+07, 2.643E+07, 2.678E+07, 2.729E+07, 2.781E+07, 2.833E+07, 2.885E+07, 2.937E+07, 2.989E+07, 3.040E+07, 3.075E+07, 3.161E+07, 1.077E+10, 3.213E+07, 3.265E+07, 3.334E+07, 3.403E+07, 3.455E+07, 3.507E+07, 8.026E+09, 3.576E+07, 3.628E+07, 3.714E+07, 3.783E+07, 3.835E+07, 7.221E+08, 3.904E+07, 8.119E+08, 4.293E+09, 3.991E+07, 4.060E+07, 4.146E+07, 4.198E+07, 4.284E+07, 4.371E+07, 4.440E+07, 4.509E+07, 4.613E+07, 4.682E+07, 4.768E+07, 4.837E+07, 4.958E+07
]

solar = xr.Dataset(
    data_vars = {
        'flux': ('wavelength', hinteregger_flux, { 'units': 'photons cm-2 s-1' })
    },
    coords = {
        'wavelength': ('wavelength', wavelengths, { 'units': 'A' })
    }
)

with ProgressBar():
    solar.to_netcdf('../../data/solar.nc', compute=False).compute()

print(solar)