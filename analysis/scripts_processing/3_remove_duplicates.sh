#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load picard/2.6.0

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
temp_dir="${root_dir}/removeDuplicate/temp"
picard_command="java -Xmx12G -XX:ParallelGCThreads=5 -XX:GCTimeLimit=50 -jar /apps/picard/2.6.0/picard.jar"

sample_name="Abcam-ab4729_1_100"
#sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"


# sort by coordinate
$picard_command SortSam I=$root_dir/alignment/sam/${sample_name}_trimmed_bowtie2.sam O=$root_dir/alignment/sam/${sample_name}_bowtie2.sorted.withDup.sam SORT_ORDER=coordinate TMP_DIR=$temp_dir

# mark duplicates
$picard_command MarkDuplicates I=$root_dir/alignment/sam/${sample_name}_bowtie2.sorted.withDup.sam O=$root_dir/removeDuplicate/${sample_name}_bowtie2.sorted.dupMarked.sam METRICS_FILE=$root_dir/removeDuplicate/picard_summary/${sample_name}_picard.dupMark.txt TMP_DIR=$temp_dir

# remove duplicates
$picard_command MarkDuplicates I=$root_dir/alignment/sam/${sample_name}_bowtie2.sorted.withDup.sam O=$root_dir/removeDuplicate/${sample_name}_bowtie2.sorted.rmDup.sam REMOVE_DUPLICATES=true METRICS_FILE=$root_dir/removeDuplicate/picard_summary/${sample_name}_picard.rmDup.txt TMP_DIR=$temp_dir