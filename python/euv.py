"""
Solar EUV Flux (photons cm^-2 s^-1)
"""

import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, AutoMinorLocator

import xarray as xr
from dask.diagnostics import ProgressBar

import numpy as np

plt.style.use('classic')

solar = xr.load_dataset('../data/solar.nc')
print(solar)

fig, ax = plt.subplots(1, 1)

ax.plot(solar.wavelength, solar.flux)

ax.set_xlabel('Wavelength ($\mathregular{A}$)')
ax.set_ylabel('Solar EUV Flux (photons $\mathregular{cm^{-2} s^{-1}}$)')
ax.set_title('Solar EUV Flux')

ax.xaxis.set_minor_locator(MultipleLocator(50))
plt.grid(True, which='major', axis='x')

ax.set_xlim(0, 1100)

plt.yscale('log')

plt.tight_layout()

savedir = input('Entire file path in which to save the figure (../out/euv.png): ')
plt.savefig(fname=savedir if savedir else '../out/euv.png')
