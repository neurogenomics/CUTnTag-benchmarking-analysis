#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load samtools/1.3.1
module load anaconda3/personal
source activate deepenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

bamCoverage="$HOME/anaconda3/envs/deepenv/bin/bamCoverage"

sample_name="Diagenode_C15410196_1_50_2M"
#sample_name="CST9733_1_100_H3K27me3_2M"


# NOTE: downsampled files have 2M paired-end reads, or 4M total reads

# ensure downsampled bam files are sorted by coordinate and indexed
samtools sort ${root_dir}/alignment/bam/${sample_name}_rmDup_bowtie2.mapped.bam -o ${root_dir}/alignment/bam/${sample_name}_rmDup_bowtie2.sorted.bam
samtools index ${root_dir}/alignment/bam/${sample_name}_rmDup_bowtie2.sorted.bam

# want to keep one mate of each of the 2M paired-end reads (using --samFlagInclude 64 argument)
$bamCoverage -b ${root_dir}/alignment/bam/${sample_name}_rmDup_bowtie2.sorted.bam -o ${root_dir}/heatmap/bigwig/${sample_name}_one_mate_raw.bw --samFlagInclude 64
