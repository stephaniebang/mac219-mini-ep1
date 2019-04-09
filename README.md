# mac219-mini-ep1

## Test battery
To make a test battery, first give the shell script `tests.sh` permission to execute with the command
```
chmod 755 tests.sh
```
and then run the script with the command
```
./tests.sh
```
The files with the resulting data will be saved in the directory ./results.

## Test results analysis
To have an analysis of the test battery results, run the R script `resultsAnalysis.R` with the command
```
Rscript resultsAnalysis.R
```
It will print on the console the data's statistics and will save a plot in the directory ./results.