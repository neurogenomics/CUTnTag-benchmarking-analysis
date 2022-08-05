#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=32gb

module load anaconda3/personal
source activate bedtools_env

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
bam_dir="/rds/general/user/la420/home/CUTnTAG/antibodies/correlation/ENCODE_peak_files/bam/sorted_bam"

# can add more marks as needed
# can specify different ranges (e.g. ENCODE peak regions) by changing bed file input
# bam files need to be sorted by coordinate
# may need to change bam headers in case of errors

bedtools multicov -bams \
$root_dir/alignment/bam/Diagenode_C15410196_1_50_rmDup.sorted.bam \
$root_dir/alignment/bam/CST9733_1_100_H3K27me3_rmDup.sorted.bam \
$bam_dir/H3K27ac_ENCFF384ZZM_sorted.bam \
$bam_dir/H3K27me3_ENCFF676ORH_sorted.bam \
-bed $root_dir/resources/hg19/hg19_500bp_windows.bed > $root_dir/correlation/hg19_500bp_overlaps_counts.txt



