library(ggplot2)

# turn off scientific notation
options(scipen = 999)

# path to results folder
path <- './results/'

# get file list in paths
files <- dir(path)

# function to print results statistics
printStatistics <- function(table) {
  times <- table$time
  m <- mean(times)
  s <- sd(times)
  
  # ci for 95%
  error <- qnorm(0.975)*s/sqrt(100)
  
  cat(
    "Mean: ", m, "s\n",
    "Min: ", min(times), "s\n",
    "Max: ", max(times), "s\n",
    "SD: ", s, "s\n",
    "CI of 95%: [", m-error, "s, ", m+error, "s]\n",
    sep=""
  )
}


## TESTS WITH ARRAY SIZE --------------------------------------------------

cat("*** Array size variation results\n")

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
suppressMessages(ggsave("results/arrayVariation.png"))

# get statistics
printStatistics(t_array)


## TESTS WITH NUMBER OF THREADS -------------------------------------------

cat("\n*** Threads variation results\n")

t_threads <- read.table(paste0(path, files[2]), header=T, sep=';')

# view table and plot
View(t_threads)

ggplot(t_threads, aes(t_threads$threads, t_threads$time)) +
  geom_point() +
  geom_smooth(method="lm", se=T) +
  labs(
    title="Threads number variation", subtitle="Array size of 1.000.000 and 1 if", y="Time (s)", x="Number of threads")

# save plot
suppressMessages(ggsave("results/threadsVariation.png"))

# get statistics
printStatistics(t_threads)


## TESTS WITH IF CHAIN SIZE -----------------------------------------------

cat("\n*** IF chain variation results\n")

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
suppressMessages(ggsave("results/ifsVariation.png"))

# get statistics
printStatistics(t_ifs)
