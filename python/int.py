import numpy as np

# ZOBS = FLOAT(STRMID(INFO(0),INDX+1,STRLEN(INFO(0)))) = 500
# TANALT = (6375.0+ZOBS)*SIN(!DTOR*LOOK)-6375.0

zenith_angles = [
    103.85, 104.53, 105.18, 105.81, 106.41, 106.99, 107.27, 107.55, 107.82, 108.09, 108.36, 108.62, 108.75, 108.88, 109.01, 109.14, 109.27, 109.39, 109.52, 109.64, 109.76, 109.89, 110.13, 110.37, 110.61, 110.85, 111.08, 111.31, 111.54, 111.76, 111.99
]

tanalt = []

for angle in zenith_angles:
    tanalt.append((6375.0+500.0)*np.sin(!DTOR*LOOK)-6375.0)