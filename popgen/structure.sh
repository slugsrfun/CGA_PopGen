#!/bin/bash
#SBATCH --job-name=structure
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16gb
#SBATCH --time=4:00:00
#SBATCH --output=/scratch/jdrobins/CGA_PopGen/popgen/structure.o
#SBATCH --error=/scratch/jdrobins/CGA_PopGen/popgen/structure.o

ml Miniforge3/24.11.3-0

source activate /home/jdrobins/veGAbears

cd /scratch/jdrobins/CGA_PopGen/popgen

Rscript render_structure.R

conda deactivate

cp 3_structure.pdf /home/jdrobins/CGA_PopGen/PDFs
cp ADMIX.* /home/jdrobins/CGA_PopGen/popgen
cp structure.vcf /home/jdrobins/CGA_PopGen/popgen

scontrol show job ${SLURM_JOB_ID}
