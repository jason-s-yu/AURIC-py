import matplotlib.pyplot as plt

import xarray as xr
from dask.diagnostics import ProgressBar

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
plt.savefig(fname='../out/ion.png')
# plt.show()
