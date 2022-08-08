#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load samtools/1.3.1
module load bedtools/2.25.0

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

#sample_name="Abcam-ab4729_1_100"
sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"


subsample_fragnum=2000000
total_reads=$(samtools view -c $root_dir/alignment/bam/${sample_name}_rmDup_bowtie2.mapped.bam)
total_frags=$((echo $total_reads / 2) | bc )
fraction=$((echo scale=3 ; echo $subsample_fragnum / $total_frags) | bc )

# using seed of 42
val=$((echo scale=3 ; echo 42 + $fraction) | bc )

# downsample
samtools view -bs $val $root_dir/alignment/bam/${sample_name}_rmDup_bowtie2.mapped.bam > $root_dir/alignment/bam/${sample_name}_2M_rmDup_bowtie2.mapped.bam

# convert bam into bed file
bedtools bamtobed -i $root_dir/alignment/bam/${sample_name}_2M_rmDup_bowtie2.mapped.bam -bedpe > $root_dir/alignment/bed/${sample_name}_2M_rmDup_bowtie2.bed

# keep the read pairs that are on the same chromosome and fragment length less than 1000bp
awk '$1==$4 && $6-$2 < 1000 {print $0}' $root_dir/alignment/bed/${sample_name}_2M_rmDup_bowtie2.bed > $root_dir/alignment/bed/${sample_name}_2M_rmDup_bowtie2.clean.bed

# only extract the fragment related columns into fragment bed file
cut -f 1,2,6 $root_dir/alignment/bed/${sample_name}_2M_rmDup_bowtie2.clean.bed | sort -k1,1 -k2,2n -k3,3n > $root_dir/alignment/bed/${sample_name}_2M_rmDup_bowtie2.fragments.bed
