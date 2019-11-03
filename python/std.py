import sys

import matplotlib.pyplot as plt 

import xarray as xr

import numpy as np

plt.style.use('classic')

chemden = xr.load_dataset('../data/chemden.nc')

fig, ax = plt.subplots(1, 1)

lower = 16
upper = 99

ax.plot(chemden['NO+'][lower:upper], chemden.level[lower:upper], label='$\mathregular{NO^+}$')
ax.plot(chemden['O2+'][lower:upper], chemden.level[lower:upper], label='O2+')
ax.plot(chemden['O+'][lower:upper], chemden.level[lower:upper], label='$\mathregular{O^+}$')
ax.plot(chemden['N(4So)'][lower:upper], chemden.level[lower:upper], label='N(4So)')
ax.plot(chemden['N+'][lower:upper], chemden.level[lower:upper], label='$\mathregular{N^+}$')
ax.plot(chemden['N2+'][lower:upper], chemden.level[lower:upper], label='N2+')
ax.plot(chemden['O+(2Do)'][lower:upper], chemden.level[lower:upper], label='$\mathregular{O^+(2Do)}$')
ax.plot(chemden['O+(2Po)'][lower:upper], chemden.level[lower:upper], label='$\mathregular{O^+(2Po)}$', linestyle='--')
ax.plot(chemden['N(2Do)'][lower:upper], chemden.level[lower:upper], label='N(2Do)', linestyle='--')
ax.plot(chemden['N(2Po)'][lower:upper], chemden.level[lower:upper], label='N(2Po)', linestyle='--')
ax.plot(chemden['O(1D)'][lower:upper], chemden.level[lower:upper], label='O(1D)', linestyle='--')
ax.plot(chemden['O(1S)'][lower:upper], chemden.level[lower:upper], label='O(1S)', linestyle='--')
ax.plot(chemden['N2(A)'][lower:upper], chemden.level[lower:upper], label='N2(A)', linestyle='--')

ax.set_xlabel('Chemical Density ($\mathregular{cm^{-3}}$)')
ax.set_ylabel('Altitude (km)')
ax.set_title('Chemical Densities')

ax.set_xlim(1, 1E10) # Leave extra space to the right to make room for the legend

plt.legend()
plt.xscale('log')

plt.tight_layout()

try:
    savedir = input('Entire file path in which to save the figure (../out/std.png): ')
    plt.savefig(fname=savedir if savedir else '../out/std.png')
except KeyboardInterrupt:
    print('Aborting.')
    sys.exit()
