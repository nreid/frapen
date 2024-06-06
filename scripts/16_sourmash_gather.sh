#!/bin/bash
#SBATCH --job-name=sourmash_gather_samples
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 20
#SBATCH --mem=50G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load parallel/20180122

source ~/.bashrc
conda activate sourmash

INDIR=../results/sourmash/samples
OUTDIR=../results/sourmash/samples_gather
mkdir -p ${OUTDIR}

DB=../results/sourmash/genomes/fraxinus-genomes.sbt.zip
SIGS=($(find $INDIR -name *sig | sort))
SAMPLES=($(find $INDIR -name *sig | sort | sed 's_.*/__ ; s/.sig//'))

for i in {0..191}
    do echo "sourmash gather -o ${OUTDIR}/${SAMPLES[$i]}.gather ${SIGS[$i]} ${DB}"
done | \
parallel -j 20

