#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load bedtools/2.25.0

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
chromSize="${root_dir}/resources/hg19/hg19.chrom.sizes"

sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"
#sample_name="Diagenode_C15410196_1_50_2M"
#sample_name="CST9733_1_100_H3K27me3_2M"


bedtools genomecov -bg -i $root_dir/alignment/bed/${sample_name}_rmDup_bowtie2.fragments.bed -g $chromSize > $root_dir/alignment/bedgraph/${sample_name}_rmDup_bowtie2.fragments.bedgraph

# downsampled samples were all deduplicated
bedtools genomecov -bg -i $root_dir/alignment/bed/${sample_name}_withDup_bowtie2.fragments.bed -g $chromSize > $root_dir/alignment/bedgraph/${sample_name}_withDup_bowtie2.fragments.bedgraph
