"""
Slant Solar EUV Photoabsorption Deposition Rates (eV cm^-3 s^-1)
"""

import matplotlib.pyplot as plt

import xarray as xr
from dask.diagnostics import ProgressBar

import numpy as np

plt.style.use('classic')

photodep = xr.load_dataset('../data/photodep.nc')

fig, ax = plt.subplots(1, 1)

lower = 0
upper = 99

ax.plot(photodep.N2[lower:upper], photodep.level[lower:upper], label='$\mathregular{N_2}$')
ax.plot(photodep.O2[lower:upper], photodep.level[lower:upper], label='$\mathregular{O_2}$')
ax.plot(photodep.O[lower:upper], photodep.level[lower:upper], label='O')

ax.set_xlabel('Slant Solar EUV Photoabsorption Deposition Rates (eV $\mathregular{cm^{-3} s^{-1}}$)')
ax.set_ylabel('Altitude (km)')
ax.set_title('Slant Solar EUV Photoabsorption Deposition')

ax.set_xlim(1)

plt.legend()
plt.xscale('log')

plt.tight_layout()

savedir = input('Entire file path in which to save the figure (../out/seuv.png): ')
plt.savefig(fname=savedir if savedir else '../out/seuv.png')
