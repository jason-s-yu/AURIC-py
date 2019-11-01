# AURIC-py

> Atmospheric Ultraviolet Radiance Integrated Code as seen in *Strickland et al.* (Journal of Quantitative Spectroscopy &
Radiative Transfer 62 (1999) 689-742), adapted for Python.

## Installation and Requirements

1. Clone the repository

    ```bash
    git clone https://github.com/jason-s-yu/AURIC-py.git
    ```

2. This project uses Python 3.7 and the following packages:

   * `dask` for parallel processing
   * `matplotlib` for plotting
   * `numpy` for numerical computations
   * `xarray` to handle NetCDF4 files and to facilitate binary conversion

    If you are using Anaconda, you may use the environment file provided by running the command:

    ```bash
    conda env create -f environment.yml
    conda activate AURIC-py
    ```

    Otherwise, you may `pip install` the packages if you do not yet have them installed:

    ```bash
    pip install dask matplotlib numpy xarray
    ```

3. Run the desired python plotting tool in [python/](python)

    ```bash
    python <tool>.py
    ```

## Data

The data used for this project is stored in [data/](data). NetCDF4 files are available in that directory, and the legacy binary files are in [data/dat/](data/dat) and [data/int](data/int).

Conversion code for each file is located in [convert.py](python/convert.py).

## IDL

The legacy IDL plots and subroutines are stored in [idl/](idl)

