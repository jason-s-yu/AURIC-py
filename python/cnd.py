"""
Slant Column Density (cm^2)
"""
import sys

import matplotlib.pyplot as plt

import xarray as xr

import numpy as np

plt.style.use('classic')

cnd = xr.load_dataset('../data/colden.nc')

fig, ax = plt.subplots(1, 1)

lower = 16
upper = 99

ax.plot(cnd.N2[lower:upper], cnd.level[lower:upper], label='$\mathregular{N_2}$')
ax.plot(cnd.O2[lower:upper], cnd.level[lower:upper], label='$\mathregular{O_2}$')
ax.plot(cnd.O[lower:upper], cnd.level[lower:upper], label='O')
ax.plot(cnd.O3[lower:upper], cnd.level[lower:upper], label='$\mathregular{O_3}$')
ax.plot(cnd.NO[lower:upper], cnd.level[lower:upper], label='NO')
ax.plot(cnd.N[lower:upper], cnd.level[lower:upper], label='N')
ax.plot(cnd.He[lower:upper], cnd.level[lower:upper], label='He')
ax.plot(cnd.H[lower:upper], cnd.level[lower:upper], label='H', linestyle='--')
ax.plot(cnd.Ar[lower:upper], cnd.level[lower:upper], label='Ar', linestyle='--')

ax.set_xlabel('Slant Column Density ($\mathregular{cm^2}$)')
ax.set_ylabel('Altitude (km)')
ax.set_title('Slant Column Densities')

plt.legend()
plt.xscale('log')

plt.tight_layout()

try:
    savedir = input('Entire file path in which to save the figure (../out/cnd.png): ')
    plt.savefig(fname=savedir if savedir else '../out/cnd.png')
except KeyboardInterrupt:
    print('\nAborting')
    sys.exit()