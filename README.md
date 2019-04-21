# Correlation between the yearly average temperature of Innsbruck with the pollution emissions of NMVOCs from transport in Austria

## Experiment overview

In this experiment, the question if the emissions of non-methane volatile organic compounds from transport in Austria have an influence on the yearly average temperature in Innsbruck will be treated.

This is done by comparing the trends of transport emissions and average temperature, as well as obtaining the correlation between those two variables.

## Folder structure

* ```src```: Contains functions defined for loading and preprocessing the temperature and pollution data that are called in the main file ```analysis.R```.
* ```data```: Contains all input sources, more detailed descriped in the next section.
* ```output```: Contains the final preprocessing version of the data we will work with.
* ```figures```: Contains all plots produced by this experiment.
* ```analysis.R```: This is the main file of this application, that executes every step needed for this experiment.

## How to run the code

The following software and libraries (+ their versions) for it have to be installed. The code also runs with older and newer versions, but to ensure the same results this ones are suggested:

* R version 3.5.1
* ```ggcorrplot``` version 0.1.2
* ```ggplot2``` version 2.2.1
* ```dplyr``` version 0.7.7
* ```tidyr``` version 0.8.2

The script can be started from the  ```proj ``` directory with the command  ```Rscript ./analysis.R ```.

## Input data

Input data has been obtained from Open Data Austria and the EU Open Data Portal. Both data sets are freely available under the Creative Commons (CC BY 3.0) licence.

### Temperature

For the average temperature of Innsbruck, the data provided under Open Data Austria (https://www.data.gv.at/katalog/dataset/5eb8278a-4ecf-41e2-a1f8-03383f31af7d, accessed on 20.04.2019) was in use.

This data contains the average temperature in Celsius measured in Innsbruck of each month in a certain year, in a time interval between 1971 and 2016.

### Pollution

For the transport pollution emission indicator, data provided by the EU Open Data Portal (http://data.europa.eu/euodp/en/data/dataset/gZmNXFTZrjPyK3EHPykmpg, accessed on 20.04.2019) was used.

This data contains the indicator of the European Union for emissions produced by transport, the main contributor to air pollution. It includes emissions from *nitrogen oxides (NOx)*, *non-methane volatile organic compounds (NMVOCs)* and *particulate matter (PM10)* and is an index to the year 2000 (indicator = 100 for this year). The values are reported under the UNECE Convention on Long-Range Transboundary Air Pollution (CLRTAP).

The data contains the three emission measurements for each EU country for the years 1990 to 2016. In the experiment, we will just focus on the Austrian data for non-methane volatile organic compounds (NMVOCs).

## Workflow

### Preprocessing

The preprocessing pipeline of this experiments consists of the following steps:

* Loading of the original temperature and pollution data
* Filtering of the data to just contain the years 1990 to 2016
* Filtering the pollution data just for NMVOC emissions in Austria
* Calculation of the average temperature of Innsbruck for each year
* Changing the data to a combined format having years, average temperature and the pollution indicator as columns and an observation as a combination of all three

### Analysis

* The correlation between the NMVOC emission and the average temperature is observed (graphically and with the Pearson correlation coefficient).
* Additionally, we also compare the trend of both values over the observed time interval.

### Output data

The output of this experiment contains the combined data used for the analysis as well as all graphics produced.

### Results

A can see a quite strong negative correlation between year and the pollution indicator has been obtained, meaning that the pollution indicator has a negative trend.

Also, there is a weak positive correlation between a year and the average temperature of Innsbruck.

No clear correlation between the NMVOC emission and the average temperature is visible. Just observing a locally weighted scatterplot smoothing (LOESS) smoothed trend, a negative correlation is visible, meaning that higher NMVOC values result in a lower average yearly temperature.


