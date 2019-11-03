"""
Electron density (cm^3)
"""
import sys

import matplotlib.pyplot as plt

import xarray as xr

import numpy as np

plt.style.use('classic')

ionos = xr.load_dataset('../data/ionos.nc')

fig, ax = plt.subplots(1, 1)

lower = 10
upper = 99

ax.plot(ionos.ion[lower:upper], ionos.level[lower:upper])

ax.set_xlabel('Electron Density ($\mathregular{cm^3}$)')
ax.set_ylabel('Altitude (km)')
ax.set_title('Electron Density')

ax.set_xlim(1E4)

plt.xscale('log')

plt.tight_layout()

try:
    savedir = input('Entire file path in which to save the figure (../out/ion.png): ')
    plt.savefig(fname=savedir if savedir else '../out/ion.png')
except KeyboardInterrupt:
    print('\nAborting')
    sys.exit()