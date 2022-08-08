#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load samtools/1.3.1
module load bedtools/2.25.0

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"

#dup="rmDup"
dup="withDup"


# ensure sam file is sorted by read name
#samtools sort -n $root_dir/removeDuplicate/${sample_name}_bowtie2.sorted.rmDup.sam -o $root_dir/alignment/sam/${sample_name}_bowtie2.n_sorted.rmDup.sam
#samtools sort -n $root_dir/alignment/sam/${sample_name}_bowtie2.sorted.withDup.sam -o $root_dir/alignment/sam/${sample_name}_bowtie2.n_sorted.withDup.sam


# filter and keep the mapped read pairs
#samtools view -bS -F 0x04 $root_dir/alignment/sam/${sample_name}_bowtie2.n_sorted.${dup}.sam > $root_dir/alignment/bam/${sample_name}_${dup}_bowtie2.mapped.bam

# convert bam into bed file
bedtools bamtobed -i $root_dir/alignment/bam/${sample_name}_${dup}_bowtie2.mapped.bam -bedpe > $root_dir/alignment/bed/${sample_name}_${dup}_bowtie2.bed

# keep the read pairs that are on the same chromosome and fragment length less than 1000bp
awk '$1==$4 && $6-$2 < 1000 {print $0}' $root_dir/alignment/bed/${sample_name}_${dup}_bowtie2.bed > $root_dir/alignment/bed/${sample_name}_${dup}_bowtie2.clean.bed

# only extract the fragment related columns into fragment bed file
cut -f 1,2,6 $root_dir/alignment/bed/${sample_name}_${dup}_bowtie2.clean.bed | sort -k1,1 -k2,2n -k3,3n > $root_dir/alignment/bed/${sample_name}_${dup}_bowtie2.fragments.bed
