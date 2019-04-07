#!/bin/bash

# function to get timestamp
timestamp() {
  date +"%Y%m%d-%H:%M:%S"
}

# create results directory
mkdir -p results

# compile contention.c
make

# making array size tests
printf "\nMaking tests with array size..."

array=10000
threads=4
ifs=1
file="results/$(timestamp)-a$array-t$threads-i$ifs.txt"

echo "array_size;threads;time" >> $file

while [ $array -le 1000000 ]
do
  ./contention $threads $array >> $file
  (( array += 10000 ))
done

printf " Done!\nSaved in $file\n"

# making threads number tests
printf "\nMaking tests with threads number..."

array=1000000
threads=1
ifs=1
file="results/$(timestamp)-a$array-t$threads-i$ifs.txt"

echo "array_size;threads;time" >> $file

while [ $threads -le 100 ]
do
  ./contention $threads $array >> $file
  (( threads++ ))
done

printf " Done!\nSaved in $file\n"

# making if chain size tests
printf "\nMaking tests with if chain size..."

array=1000000
threads=4
ifs=1
max_ifs=100
file="results/$(timestamp)-a$array-t$threads-i$max_ifs.txt"

echo "array_size;threads;time" >> $file

while [ $ifs -le $max_ifs ]
do
  make IF=$ifs
  ./contention $threads $array >> $file
  (( ifs ++ ))
done

printf " Done!\nSaved in $file\n\nEnd of script\n"

