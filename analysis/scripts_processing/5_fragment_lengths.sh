#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load samtools/1.3.1

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

sample_name="Diagenode_C15410196_1_50"
#sample_name="CST9733_1_100_H3K27me3"


## extract the 9th column from the sam file (fragment length)

# no duplicates
samtools view -F 0x04 $root_dir/removeDuplicate/${sample_name}_bowtie2.sorted.rmDup.sam | awk -F'\t' 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($9)}' | sort | uniq -c | awk -v OFS="\t" '{print $2, $1/2}' > $root_dir/alignment/sam/fragmentLen/${sample_name}_rmDup_fragmentLen.txt

# with duplicates
samtools view -F 0x04 $root_dir/alignment/sam/${sample_name}_bowtie2.sorted.withDup.sam | awk -F'\t' 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($9)}' | sort | uniq -c | awk -v OFS="\t" '{print $2, $1/2}' > $root_dir/alignment/sam/fragmentLen/${sample_name}_withDup_fragmentLen.txt
