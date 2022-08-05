#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load bowtie2/2.2.9

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
outdir="${root_dir}/alignment/sam"
ref="/rds/general/user/la420/home/hg19/index/genome"
cores=8

sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"


bowtie2 \
--local \
--very-sensitive \
--no-mixed \
--no-discordant \
--phred33 \
-I 10 \
-X 700 \
-p ${cores} \
-x ${ref} \
-1 ${root_dir}/fastq/trimmed/${sample_name}_val_1.fq.gz \
-2 ${root_dir}/fastq/trimmed/${sample_name}_val_2.fq.gz \
-S ${outdir}/${sample_name}_trimmed_bowtie2.sam &> ${outdir}/bowtie2_summary/${sample_name}_bowtie2.txt


