import matplotlib.pyplot as plt

import xarray as xr
from dask.diagnostics import ProgressBar

import numpy as np

plt.style.use('classic')

atmos = xr.load_dataset('../data/atmos.nc')

fig, ax = plt.subplots(1, 1)

lower = 16
upper = 99

ax.plot(atmos.temperature[lower:upper], atmos.level[lower:upper], label='Temperature')
ax.plot(atmos.N2[lower:upper], atmos.level[lower:upper], label='$\mathregular{N_2}$')
ax.plot(atmos.O2[lower:upper], atmos.level[lower:upper], label='$\mathregular{O_2}$')
ax.plot(atmos.O[lower:upper], atmos.level[lower:upper], label='O')
ax.plot(atmos.O3[lower:upper], atmos.level[lower:upper], label='$\mathregular{O_3}$')
ax.plot(atmos.NO[lower:upper], atmos.level[lower:upper], label='NO')
ax.plot(atmos.N[lower:upper], atmos.level[lower:upper], label='N')
ax.plot(atmos.He[lower:upper], atmos.level[lower:upper], label='He', linestyle='--')
ax.plot(atmos.H[lower:upper], atmos.level[lower:upper], label='H', linestyle='--')
ax.plot(atmos.Ar[lower:upper], atmos.level[lower:upper], label='Ar', linestyle='--')

ax.set_xlabel('Density ($\mathregular{cm^3}$)')
ax.set_ylabel('Altitude (km)')
ax.set_title('Neutral Densities')

ax.set_xlim(1)

plt.legend()
plt.xscale('log')

plt.tight_layout()

savedir = input('Entire file path in which to save the figure (../out/atmos.png): ')
plt.savefig(fname=savedir if savedir else '../out/atmos.png')
