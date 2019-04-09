library(ggplot2)

# turn off scientific notation
options(scipen = 999)

# path to results folder
path <- './results/'

# get file list in paths
files <- dir(path)


## TESTS WITH ARRAY SIZE --------------------------------------------------

t_array <- read.table(paste0(path, files[1]), header=T, sep=';')

# view table and plot
View(t_array)

ggplot(t_array, aes(t_array$array_size, t_array$time)) +
  geom_point() +
  geom_smooth(method="lm", se=T) +
  labs(
    title="Array size variation",
    subtitle="4 threads and 1 if",
    y="Time (s)",
    x="Array size"
  )

# save plot
ggsave("results/arrayVariation.png")

# get statistics
m <- mean(t_array$time)
s <- sd(t_array$time)

# ci for 95%
error <- qnorm(0.975)*s/sqrt(100)

# print results
m
min(t_array$time)
max(t_array$time)
s
m-error
m+error


## TESTS WITH NUMBER OF THREADS -------------------------------------------

t_threads <- read.table(paste0(path, files[2]), header=T, sep=';')

# view table and plot
View(t_threads)

ggplot(t_threads, aes(t_threads$threads, t_threads$time)) +
  geom_point() +
  geom_smooth(method="lm", se=T) +
  labs(
    title="Threads number variation", subtitle="Array size of 1.000.000 and 1 if", y="Time (s)", x="Number of threads")

# save plot
ggsave("results/threadsVariation.png")

# get statistics
m <- mean(t_threads$time)
s <- sd(t_threads$time)

# ci for 95%
error <- qnorm(0.975)*s/sqrt(100)

# print results
m
min(t_threads$time)
max(t_threads$time)
s
m-error
m+error


## TESTS WITH IF CHAIN SIZE -----------------------------------------------

t_ifs <- read.table(paste0(path, files[3]), header=T, sep=';')

# Add ifs column
t_ifs$ifs <- c(0:100)

# View table and plot
View(t_ifs)

ggplot(t_ifs, aes(t_ifs$ifs, t_ifs$time)) +
  geom_point() +
  geom_smooth(method="lm", se=T) +
  labs(
    title="IF chain size variation",
    subtitle="4 threads and array size of 1.000.000",
    y="Time (s)",
    x="Size of IF chain size"
  )

# save plot
ggsave("results/ifsVariation.png")

# get statistics
m <- mean(t_ifs$time)
s <- sd(t_ifs$time)

# ci for 95%
error <- qnorm(0.975)*s/sqrt(100)

# print results
m
min(t_ifs$time)
max(t_ifs$time)
s
m-error
m+error
