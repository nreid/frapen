#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=4G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err


#######################
# run multiqc
#######################

# aggregate fastqc reports

# input, output directories
INDIR=../results/fastqc_pre_clonefilter

OUTDIR=../results/multiqc_pre_clonefilter
mkdir -p $OUTDIR


module load MultiQC/1.9

multiqc --outdir $OUTDIR $INDIR

# input, output directories
INDIR=../results/fastqc_post_clonefilter

OUTDIR=../results/multiqc_post_clonefilter
mkdir -p $OUTDIR


module load MultiQC/1.9

multiqc --outdir $OUTDIR $INDIR