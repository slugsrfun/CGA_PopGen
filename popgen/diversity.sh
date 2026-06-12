#!/bin/bash
#SBATCH --job-name=diversity
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_PopGen/popgen/diversity.o
#SBATCH --error=/scratch/jdrobins/CGA_PopGen/popgen/diversity.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_PopGen/popgen

Rscript render_diversity.R

conda deactivate 

cp 2_diversity.pdf /home/jdrobins/CGA_PopGen/PDFs

scontrol show job ${SLURM_JOB_ID}