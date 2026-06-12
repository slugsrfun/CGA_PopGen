#!/bin/bash
#SBATCH --job-name=effectiveSize
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_PopGen/popgen/effectiveSize.o
#SBATCH --error=/scratch/jdrobins/CGA_PopGen/popgen/effectiveSize.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_PopGen/popgen

Rscript render_effectiveSize.R

conda deactivate

cp 4_effectiveSize.pdf /home/jdrobins/CGA_PopGen/PDFs
cp CGA_NexLD.txt /home/jdrobins/CGA_PopGen/popgen
cp CGA_Ne.txt /home/jdrobins/CGA_PopGen/popgen
cp combined.vcf /home/jdrobins/CGA_PopGen/popgen

scontrol show job ${SLURM_JOB_ID}
