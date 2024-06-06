#!/bin/bash
#SBATCH --job-name=sourmash_genomes
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=50G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

conda activate sourmash

INDIR=../genome
OUTDIR=../results/sourmash/genomes/
mkdir -p ${OUTDIR}

ASHES=(americana_m latifolia nigra pennsylvanica quadrangulata)

# generate signatures
for species in ${ASHES[@]}
    do sourmash sketch dna -p k=31,scaled=1000,noabund  --name ${species} -o ${OUTDIR}/${species}.sig ${INDIR}/${species}.fasta
done

# compare signatures and plot
sourmash compare ${OUTDIR}/*.sig -o ${OUTDIR}/compare_all.mat
sourmash plot --output-dir ${OUTDIR} ${OUTDIR}/compare_all.mat

# make a search database:
sourmash index -k 31 ${OUTDIR}/fraxinus-genomes ${OUTDIR}/*.sig