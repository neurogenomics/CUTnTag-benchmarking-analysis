#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

## need cutadapt for TrimGalore
module load anaconda3/personal
source activate cutadaptenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
trimgalore_path="/rds/general/user/la420/home/TrimGalore-0.6.6"

sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"


# may need to gunzip to avoid bad gzip error
$trimgalore_path/trim_galore -o $root_dir/fastq/trimmed --gzip --basename $sample_name --paired $root_dir/fastq/${sample_name}_R1.fastq $root_dir/fastq/${sample_name}_R2.fastq


