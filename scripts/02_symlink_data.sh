#!/bin/bash
#SBATCH --job-name=symlink_data
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


hostname
date

# symlink data to raw data directory 

mkdir -p ../rawdata

for file in $(find /core/cbc/CGI_data/FRAPEN* -name "*fastq.gz" | sort)

do ln -s $file ../rawdata/

done