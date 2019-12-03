import numpy as np
import pandas as pd
import matplotlib as mpl
mpl.use('TkAgg')
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d

def plot3D(x, y, z, c, title, xlabel, ylabel, zlabel, clabel, cticks, fig_num, fig_size, size=10):
    fig = plt.figure(num=fig_num, figsize=fig_size)
    ax = fig.add_subplot(111, projection='3d')
    scat = ax.scatter(x, y, z, c=c, s=size)
    cb = plt.colorbar(scat, spacing='proportional', ticks=cticks)
    cb.set_label(clabel)
    ax.set_title(title)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_zlabel(zlabel)
    ax.invert_zaxis()

def main():
    results_folder = '../results'
    ctd_file = 'ctd_harald_corrected.csv'
    wq_file = 'water_quality_harald_corrected.csv'
    ctd_path = results_folder + '/' + ctd_file
    wq_path = results_folder + '/' + wq_file
    
    ctd_df = pd.read_csv(ctd_path, sep=',')
    wq_df = pd.read_csv(wq_path, sep=',')

    print(ctd_df)
    print(wq_df)
    
    size = 8
    fig_size = (12, 6)
    d_threshold = 0.5 # Depth threshold
    l_threshold = 10.52 # Longitude threshold

    # Harald CTD data
    depths = ctd_df['depth'].values
    longitudes = ctd_df['longitudeCorr'].values
    mask = np.logical_and(depths > d_threshold, longitudes < l_threshold)
    depths = depths[mask]
    longitudes = longitudes[mask]
    latitudes = ctd_df['latitudeCorr'].values[mask]
    conducts = ctd_df['conductivity'].values[mask]
    temps = ctd_df['temperature'].values[mask]
    salinities = ctd_df['salinity'].values[mask]

    mask = longitudes < 10.52
    longitudes = longitudes[mask]
    latitudes = latitudes[mask]
    depths = depths[mask]
    conducts = conducts[mask]
    temps = temps[mask]
    salinities = salinities[mask]

    # Conductivity-, temperature- and salinity plot
    ticks = np.linspace(np.min(conducts), np.max(conducts), 10)
    plot3D(longitudes, latitudes, depths, conducts, 'Conductivity along Harald\'s trajectory', 
            'Longitude', 'Latitude', 'Depth', 'Conductivity [S/m]', ticks, 1, fig_size, size)
    ticks = np.linspace(np.min(temps), np.max(temps), 10)
    plot3D(longitudes, latitudes, depths, temps, 'Temperature along Harald\'s trajectory',
            'Longitude', 'Latitude', 'Depth', 'Temperature [\u03B1C]', ticks, 2, fig_size, size)
    ticks = np.linspace(np.min(salinities), np.max(salinities), 10)
    plot3D(longitudes, latitudes, depths, salinities, 'Salinity along Harald\'s trajectory',
            'Longitude', 'Latitude', 'Depth', 'Salinity [g/kg]', ticks, 3, fig_size, size)

    # Harald water quality data
    depths = wq_df['Depth'].values
    longitudes = wq_df['Longitude'].values
    mask = np.logical_and(depths > d_threshold, longitudes < l_threshold)
    depths = depths[mask]
    longitudes = longitudes[mask]
    latitudes = wq_df['Latitude'].values[mask]
    chloros = wq_df['Chlorophyll'].values[mask]
    c_doms = wq_df['cDOM'].values[mask]
    oxygens = wq_df['DissolvedOxygen'].values[mask]

    # Chlorophyll-, cDOM- and dissolved oxygen plot
    ticks = np.linspace(np.min(chloros), np.max(chloros), 10)
    plot3D(longitudes, latitudes, depths, chloros, 'Chlorophyll A along Harald\'s trajectory', 
            'Longitude', 'Latitude', 'Depth', 'Chlorophyll a [\u03BCg/L]', ticks, 4, fig_size, size)
    ticks = np.linspace(np.min(c_doms), np.max(c_doms), 10)
    plot3D(longitudes, latitudes, depths, c_doms, 'cDOM along Harald\'s trajectory',
            'Longitude', 'Latitude', 'Depth', 'cDOM [ppb]', ticks, 5, fig_size, size)
    ticks = np.linspace(np.min(oxygens), np.max(oxygens), 10)
    plot3D(longitudes, latitudes, depths, oxygens, 'Dissolved oxygen along Harald\'s trajectory',
            'Longitude', 'Latitude', 'Depth', 'Dissolved oxygen [\u03BCm]', ticks, 6, fig_size, size)

    plt.show()

if __name__ == '__main__':
    main()
