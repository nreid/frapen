#!/bin/bash
#SBATCH --job-name=kraken_search
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200G
#SBATCH --partition=mcbstudent
#SBATCH --qos=mcbstudent
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date


source ~/.bashrc
conda activate kraken2
module load jellyfish/2.2.6
module load blast/2.13.0

# unfinished script...

kraken2 -db ../results/kraken/db/fraxinusDB \
    --use-names \
    --threads 16 \
    --output ${SAMPLE}.out \
    --report ${SAMPLE}_report.txt \
    --use-mpa-style \
    ${FQ1} 


