#!/bin/bash
#SBATCH --job-name=MHCdiversity
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_PopGen/popgen/MHCdiversity.o
#SBATCH --error=/scratch/jdrobins/CGA_PopGen/popgen/MHCdiversity.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_PopGen/popgen

Rscript render_MHCdiversity.R

conda deactivate

cp 5_MHCdiversity.pdf /home/jdrobins/CGA_PopGen/PDFs/
cp DQB*.vcf /home/jdrobins/CGA_PopGen/popgen/
cp DQB*.csv /home/jdrobins/CGA_PopGen/popgen/
cp DQBex2.samples /home/jdrobins/CGA_PopGen/popgen/
cp DQBex2.hap /home/jdrobins/CGA_PopGen/popgen/

scontrol show job ${SLURM_JOB_ID}