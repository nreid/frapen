#!/bin/bash
#SBATCH --job-name=clone_filter
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=noah.reid@uconn.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --array=[0-191]

echo "host name : " `hostname`
echo This is array task number $SLURM_ARRAY_TASK_ID

module load stacks/2.64

#input/output directories, supplementary files
INDIR=../results/demultiplexed_fastqs/
OUTDIR=../results/clone_filtered_fastqs/
mkdir -p $OUTDIR

FASTQ1=($(find ${INDIR} -name "*1.fq.gz" | grep -v "rem.1" | sort))
FASTQ2=($(find ${INDIR} -name "*2.fq.gz" | grep -v "rem.2" | sort))

FQ1=${FASTQ1[$SLURM_ARRAY_TASK_ID]}
FQ2=${FASTQ2[$SLURM_ARRAY_TASK_ID]}

# run clone_filter
	# expected oligo sequence in R2: NNNNNHMMGG followed by TAA MseI recognition sequence. 

clone_filter \
-i gzfastq \
-o $OUTDIR \
-1 $FQ1 \
-2 $FQ2 \
--null_inline \
--oligo_len_1 10