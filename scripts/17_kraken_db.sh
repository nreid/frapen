#!/bin/bash
#SBATCH --job-name=kraken_db
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200G
#SBATCH --partition=general
#SBATCH --qos=general
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

OUTDIR=../results/kraken/db
mkdir -p ${OUTDIR}

cd ${OUTDIR}

DBNAME=fraxinusDB

kraken2-build --download-taxonomy --db $DBNAME

kraken2-build --download-library archaea --db $DBNAME
kraken2-build --download-library bacteria --db $DBNAME
kraken2-build --download-library fungi --db $DBNAME
kraken2-build --download-library plant --db $DBNAME

kraken2-build --threads 16 --build --db $DBNAME

