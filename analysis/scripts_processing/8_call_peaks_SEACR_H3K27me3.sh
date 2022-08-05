#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate seacr_env

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
seacr="bash $HOME/anaconda3/envs/seacr_env/bin/SEACR_1.3.sh"

sample_name="CST9733_1_100_H3K27me3"
#sample_name="CST9733_1_100_H3K27me3_2M"

threshold="0.1"



## call peaks

$seacr $root_dir/alignment/bedgraph/${sample_name}_rmDup_bowtie2.fragments.bedgraph $threshold non stringent $root_dir/peakCalling/SEACR/${sample_name}_rmDup_seacr_top${threshold}_peaks

$seacr $root_dir/alignment/bedgraph/${sample_name}_withDup_bowtie2.fragments.bedgraph $threshold non stringent $root_dir/peakCalling/SEACR/${sample_name}_withDup_seacr_top${threshold}_peaks



## get summits for heatmaps

awk '{split($6, summit, ":"); split(summit[2], region, "-"); print summit[1]"\t"region[1]"\t"region[2]}' $root_dir/peakCalling/SEACR/${sample_name}_rmDup_seacr_top${threshold}_peaks.stringent.bed > $root_dir/heatmap/summits/${sample_name}_2M_seacr_top${threshold}_peaks.summitRegion.bed