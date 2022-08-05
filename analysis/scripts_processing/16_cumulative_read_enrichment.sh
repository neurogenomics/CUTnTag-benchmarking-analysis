#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate deepenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

sample_1="Diagenode_C15410196_1_50_2M"
sample_2="CST9733_1_100_H3K27me3_2M"

plotFingerprint --bamfiles $root_dir/alignment/bam/${sample_1}_rmDup.sorted.bam \
$root_dir/alignment/bam/${sample_2}_rmDup.sorted.bam \
$root_dir/resources/ENCODE/bam/H3K27ac_ENCSR000AKP_merged.nodup.2M.sorted.bam \
--plotFile $root_dir/heatmap/cumulative_read_enrichment/cumulative_read_enrichments.png \
--binSize=1000 \
--labels $sample_1 $sample_2 "ENCODE_H3K27ac"