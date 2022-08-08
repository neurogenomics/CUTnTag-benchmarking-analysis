#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate homerenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

sample_name="Diagenode_C15410196_1_50_SEACR"
#sample_name="CST9733_1_100_H3K27me3_SEACR"
#sample_name="Diagenode_C15410196_1_50_MACS2"
#sample_name="CST9733_1_100_H3K27me3_MACS2"


mkdir $root_dir/motifs/${sample_name}

findMotifsGenome.pl $root_dir/peakCalling/all_peaks/${sample_name}.bed hg19 $root_dir/motifs/${sample_name} -size 1000

# ENCODE peaks
#mkdir $root_dir/motifs/ENCODE_H3K27ac
#mkdir $root_dir/motifs/ENCODE_H3K27me3
#findMotifsGenome.pl $root_dir/resources/ENCODE/peaks/H3K27ac_ENCFF044JNJ.bed.narrowPeak hg19 $root_dir/motifs/ENCODE_H3K27ac -size 1000
#findMotifsGenome.pl $root_dir/resources/ENCODE/peaks/H3K27me3_ENCFF000BXB.bed.broadPeak hg19 $root_dir/motifs/ENCODE_H3K27me3 -size 1000
