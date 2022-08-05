#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load samtools/1.3.1

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

sample_name="CST9733_1_100_H3K27me3"
#sample_name="CST9733_1_100_H3K27me3_2M"

# ensure bam files are sorted by coordinate and indexed for peak calling with MACS2
samtools sort -o $root_dir/alignment/bam/${sample_name}_rmDup.sorted.bam $root_dir/alignment/bam/${sample_name}_rmDup_bowtie2.mapped.bam
samtools index $root_dir/alignment/bam/${sample_name}_rmDup.sorted.bam

samtools sort -o $root_dir/alignment/bam/${sample_name}_withDup.sorted.bam $root_dir/alignment/bam/${sample_name}_withDup_bowtie2.mapped.bam
samtools index $root_dir/alignment/bam/${sample_name}_withDup.sorted.bam




module load anaconda3/personal
source activate macs2_env

# q-value threshold
threshold="1e-5"


# using --broad flag for me3 mark, otherwise same settings
macs2 callpeak -t ${root_dir}/alignment/bam/${sample_name}_rmDup.sorted.bam \
-f BAMPE \
-g hs \
-q ${threshold} \
--keep-dup all \
–nolambda \
--broad \
--nomodel \
--outdir ${root_dir}/peakCalling/MACS2 \
-n ${sample_name}_rmDup_q${threshold}


macs2 callpeak -t ${root_dir}/alignment/bam/${sample_name}_withDup.sorted.bam \
-f BAMPE \
-g hs \
-q ${threshold} \
--keep-dup all \
–nolambda \
--broad \
--nomodel \
--outdir ${root_dir}/peakCalling/MACS2 \
-n ${sample_name}_withDup_q${threshold}