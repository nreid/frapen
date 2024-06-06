#!/bin/bash
#SBATCH --job-name=get_genome
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --mem=20G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

######################
# get reference genome
######################

# download genome assembly for peromyscus maniculatus bairdii
# NCBI accession # GCA_003704035.3

# output directory
GENOMEDIR=../genome
mkdir -p $GENOMEDIR

# download genome
# genome provided by Jill Wegrzyn in a google drive. Let's hash it for identification purposes:

GENOME=../genome/pennsylvanica.fasta
md5sum $GENOME >../genome/pennsylvanica.fasta.md5

# index the genome using bwa
module load bwa/0.7.17
bwa index \
-p $GENOMEDIR/frapen \
$GENOME

# index the genome using samtools
module load samtools/1.10
samtools faidx $GENOME