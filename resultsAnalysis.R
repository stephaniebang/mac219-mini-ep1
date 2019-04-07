library(ggplot2)

# turn off scientific notation
options(scipen = 999)

# path to results folder
path <- './results/'

# get file list in paths
files <- dir(path)


## TESTS WITH ARRAY SIZE --------------------------------------------------

t4f1 <- read.table(paste0(path, files[1]), header=T, sep=';')

# View table and plot
View(t4f1)
qplot(t4f1$array_size, t4f1$time, main='4 threads and 1 if', xlab='Array size', ylab='Time (s)')

m <- mean(t4f1$time)
s <- sd(t4f1$time)

# ci for 95%
error <- qnorm(0.975)*s/sqrt(100)

# print results
m
min(t4f1$time)
max(t4f1$time)
m-error
m+error


## TESTS WITH NUMBER OF THREADS -------------------------------------------

i1a100000 <- read.table(paste0(path, files[2]), header=T, sep=';')

# View table and plot
View(i1a100000)
qplot(i1a100000$threads, i1a100000$time, main='array size of 1.000.000 and 1 if', xlab='Number of threads', ylab='Time (s)')

times <- i1a100000$time
m <- mean(times)
s <- sd(times)

# ci for 95%
error <- qnorm(0.975)*s/sqrt(100)

# print results
m
min(times)
max(times)
m-error
m+error



## TESTS WITH IF CHAIN SIZE -----------------------------------------------

t4a100000 <- read.table(paste0(path, files[3]), header=T, sep=';')

# Add ifs column
t4a100000$ifs <- c(1:100)

# View table and plot
View(t4a100000)
qplot(t4a100000$ifs, t4a100000$time, main='4 threads and array size of 1.000.000', xlab='Number of if\'s', ylab='Time (s)')

times <- t4a100000$time
m <- mean(times)
s <- sd(times)

# ci for 95%
error <- qnorm(0.975)*s/sqrt(100)

# print results
m
min(times)
max(times)
m-error
m+error
