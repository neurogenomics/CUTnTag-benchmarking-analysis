#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate bedtools_env

bedtools makewindows -g hg19.chrom.sizes -w 500 > hg19_500bp_windows.bed

