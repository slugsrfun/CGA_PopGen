#!/bin/bash
#SBATCH --job-name=filtPG
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_PopGen/snpfiltering/filterPopGen.o
#SBATCH --error=/scratch/jdrobins/CGA_PopGen/snpfiltering/filterPopGen.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_PopGen/snpfiltering

Rscript render_filterPopGen.R

conda deactivate 

cp 1_filterPopGen.pdf /home/jdrobins/CGA_PopGen/PDFs
cp PopGen.vcf /home/jdrobins/CGA_PopGen/snpfiltering

scontrol show job ${SLURM_JOB_ID}
