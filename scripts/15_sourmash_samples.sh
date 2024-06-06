#!/bin/bash
#SBATCH --job-name=sourmash_samples
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

INDIR=../results/demultiplexed_fastqs/

OUTDIR=../results/sourmash/samples
mkdir -p ${OUTDIR}

FQS=($(find ${INDIR} -name "*fq.gz" | grep -v "rem...fq.gz" | grep -v "2.fq.gz" | sort))
SAMPLES=($(find ${INDIR} -name "*fq.gz" | grep -v "rem...fq.gz" | grep -v "2.fq.gz" | sort | sed 's_.*/__ ; s/.1.fq.gz//'))

for i in {0..191}
    do echo "sourmash sketch dna -p k=31,scaled=1000,noabund --name ${SAMPLES[$i]} -o ${OUTDIR}/${SAMPLES[$i]}.sig ${FQS[$i]}"
done | \
parallel -j 20

sourmash compare ${OUTDIR}/*.sig -o ${OUTDIR}/compare_all.mat
sourmash plot --output-dir ${OUTDIR} ${OUTDIR}/compare_all.mat
