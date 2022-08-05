#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate homerenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"

#sample_name="Diagenode_C15410196_1_50"
sample_name="CST9733_1_100_H3K27me3"


# SEACR peaks
#mkdir $root_dir/motifs/SEACR/${sample_name}
## ac
#findMotifsGenome.pl $root_dir/peakCalling/SEACR/${sample_name}_rmDup_seacr_top0.01_peaks.stringent.bed hg19 $root_dir/motifs/SEACR/${sample_name} -size 1000
## me3
#findMotifsGenome.pl $root_dir/peakCalling/SEACR/${sample_name}_rmDup_seacr_top0.1_peaks.stringent.bed hg19 $root_dir/motifs/SEACR -size 1000


# MACS2 peaks
#mkdir $root_dir/motifs/MACS2/${sample_name}
## ac
#findMotifsGenome.pl $root_dir/peakCalling/MACS2/${sample_name}_rmDup_q1e-5_peaks.narrowPeak hg19 $root_dir/motifs/MACS2/${sample_name} -size 1000
## me3
findMotifsGenome.pl $root_dir/peakCalling/MACS2/${sample_name}_rmDup_q1e-5_peaks.broadPeak hg19 $root_dir/motifs/MACS2/${sample_name} -size 1000

