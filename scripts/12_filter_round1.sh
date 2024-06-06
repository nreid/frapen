#!/bin/bash
#SBATCH --job-name=filter_vcfs
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
# filter variant sets
##################################

    module load bcftools/1.9
    module load htslib/1.9
    module load vcftools/0.1.16
    module load vcflib/1.0.0-rc1


###############################
# set input, output directories
###############################

STACKS=../results/stacks

FB=../results/freebayes

#############################
# filter SITES by missingness
#############################

# also remove multiallelic sites and indels

# stacks
vcftools --gzvcf $STACKS/populations.snps.dict.vcf.gz \
	--max-missing 0.5 --mac 3 --remove-indels --max-alleles 2 --min-alleles 2 \
	--recode \
	--stdout | \
	bgzip >$STACKS/filtered.vcf.gz

	# index
	tabix -p vcf $STACKS/filtered.vcf.gz

# freebayes
GEN=../genome/pennsylvanica.fasta
bcftools norm -f $GEN $FB/freebayes.vcf.gz | \
	vcfallelicprimitives --keep-info --keep-geno | \
	vcfstreamsort | \
	vcftools --vcf - \
	--max-missing 0.5 --mac 3 --remove-indels --max-alleles 2 --min-alleles 2 --minQ 30 \
	--recode \
	--stdout | bgzip >$FB/fb_filtered.vcf.gz

	# index
	tabix -p vcf $FB/fb_filtered.vcf.gz