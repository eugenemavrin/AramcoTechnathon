# AramcoTechnathon

task:
https://github.com/aramcoinnovations/technathon2019/tree/master/challenge3?roistat_visit=32528

event:
https://codenrock.com/contests/155#/nominations/207

How to work with parsed data from pdf plots.

## Subtask 1. Plots

### Raw SVG plots data (cloud of points)
Extracted SVG files are stored in **pdfs** folder.

Extracted SVG polylines are stored in *.txt*, data format: `X.f,Y.f;`.

X scale is located in filename. X may get any value, Y has value of non-decreasing function. X value is needed to normalize by scale for cross-comparing. The scale is valid for 0 < X < 140. Another X data is needed for forecasting.

Each well also have *depth.range* file: `min_depth max_depth best_min best_max`.

Where:
* `min_depth` is the minimum value on a plot grid (for scaling)
* `max_depth` is the maximum value on a plot grid (for scaling)
* `best_min` is the minimum value on a plot where we have all the data (for cutting)
* `best_max` is the maximum value on a plot where we have all the data (for cutting)

We removed the *6509_7-4* and *6204_10-2_A* wells because they made combined `best_min` and `best_max` range too small.

For these we used MATLAB script (`./pdfs/anlz_depth_ranges.m`)

### Normalized vector data (1D with const step over *depth* axis)
Generated files are stored in **well_logs** folder.

The SVG is being parsed from cloud of points into the linear interpolated vector of plot values with constant step.

You can use MATLAB to generate these files (run `./pdfs/parser.m`).
