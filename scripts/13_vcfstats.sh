#!/bin/bash
#SBATCH --job-name=vcfstats
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

##################################
# some vcf stats
##################################

module load bcftools/1.9
module load htslib/1.9
module load vcftools/0.1.16
module load vcflib/1.0.0-rc1
module load vt

# stacks
INDIR=../results/stacks/
PREFIX=stacks
VCF=../results/stacks/filtered.vcf.gz

vcftools --gzvcf ${VCF} --missing-indv --out ${INDIR}/${PREFIX}
vcftools --gzvcf ${VCF} --missing-site --out ${INDIR}/${PREFIX}
vt peek ${VCF}

# freebayes
INDIR=../results/freebayes/
PREFIX=freebayes
VCF=../results/freebayes/fb_filtered.vcf.gz

vcftools --gzvcf ${VCF} --missing-indv --out ${INDIR}/${PREFIX}
vcftools --gzvcf ${VCF} --missing-site --out ${INDIR}/${PREFIX}
vt peek ${VCF}

