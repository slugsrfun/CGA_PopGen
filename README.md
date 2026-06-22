# CGA_PopGen
Population genetic data analyses for central GA black bear data

## Directory Structure


+ `/PDFs/` - markdowns for all analyses
+ `/setup/` - code to create a virtual environment for data analysis
    + `0_build_ve.sh` - script used (interactively) to build the virtual environment for analyses that follow
        + `veGAbears_pkglist.txt` - explicit list of packages installed in creation of the virtual environment `veGAbears`
    + `/data/jax_bbear/` - folder with reference genome information for SNP annotation in  [`snpEff`](https://pcingola.github.io/SnpEff/) ([Cingolani et al. 2012](http://dx.doi.org/10.4161/fly.19695)), downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/9643/)
        + `sequences.fa` - the reference genome in FASTA format ("Genome sequences" from [NCBI download](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/9643/))
        + `genes.gtf` - annotation information in GTF format ("Annotation features (GTF)" from [NCBI download](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/9643/))
+ `/input/` - variety of files needed as input in analysis scripts
    + `CGA_info.txt` & `CGA_option.txt` - input files for `NeEstimator` (see `21_effectiveSize`)
    + `colonydat_create2.R` - modified version of function to create `COLONY` input files, from [Ellie Weise's GitHub](https://github.com/weiseell/NbdLamprey/blob/master/Homebrew/colonydat_create.R)
    + `UGA_bbh_Prod1_all_Genotypes.csv` - genetic data for samples submitted for GT-seq genotyping at GTSeek
    + `sampleMetaData_cloneID.csv` - Metadata for all samples, from [Robinson et al. (*in review*)]()
    + `Finalized Hair Samples w Metadata_Carr.csv` - information on the locations (hair snares), weeks, and years where samples were collected along with sample IDs
+ `/snpfiltering/` - steps involved in filtering capture-seq and GT-seq data for recapture / population genetic analyses
    + `1_filterPopGen` - Apply initial filters for population genetic analyses, remove duplicated genotypes
        + `PopGen.vcf` - filtered VCF for population genetic analysis
+ `/popgen/` - characterizing genetic diveristy and population structure
    + `2_diversity` - calculate summaries of genetic diversity for each population in the dataset
    + `3_structure` - calculate measures of genetic differentiation among populations, run `admixture` and DAPC
        + `ADMIX.*` - various outputs from the `admixture` analysis
        + `structure.vcf` - vcf file used for structure analyses
    + `4_effectiveSize` - estimate contemporary effective population size ($N_e$) for each population, estimate past changes in $N_e$ using `GONE` and `LinkNe`
        + `CGA_Ne*` - outputs from Ne estimation from LD
        + `combined.vcf` - vcf file used for diversity and effective population size analyses
    + `5_MHCdiversity` - summarize diversity at SNPs in MHC loci (exon 2 of *DQB*) across populations
        + `DQB*.vcf` - various `.vcf` files created for exons 2 and 6 of *DQB*
        + `DQBex2anns.csv` - annotation of SNPs within exon 2 of *DQB* (filtered for quality, etc. in the `MHCdiversity` analysis)
        + `DQBex2.hap` & `DQBex2.samples` - statistically phased (via `beagle`) SNPs in exon 2 of *DQB*, extacted with `bcftools convert --hapsample`

## The pipeline / order of events for the analysis

0. `setup/0_build_ve.sh` - create the virtual environment on the UGA cluster, install R packages, etc.
1. `snpfiltering/1_filterPopGen` - filter SNPs for pop gen analyses
2. `popgen/2_diversity` - calculate summaries of genetic diversity for populations in the dataset (heterozygosity, allelic richness, inbreeding coefficients, etc.)
3. `popgen/3_structure` - estimate measures of population genetic differentiation ($F_{ST}$), apply model-free (PCA) and model-based (`admixture`) clustering analyses 
4. `popgen/4_effectiveSize` - estimate $N_e$ using the LD method ([Hill 1981](https://doi.org/10.1017/S0016672300020553), [Waples et al. 2016](https://doi.org/10.1038/hdy.2016.60)) in `NeEstimator` ([Do et al. 2014](https://doi.org/10.1111/1755-0998.12157))
5. `popgen/5_MHCdiversity` - extract SNPs in exon II of *DQB* (an MHC class II gene) and summarize diversity across Georgia's black bear populations

