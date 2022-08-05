#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate deepenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
blacklist="/rds/general/user/la420/home/hg19/other/hg19-blacklist.v2.bed.gz"
plotHeatmap="$HOME/anaconda3/envs/deepenv/bin/plotHeatmap"
computeMatrix="$HOME/anaconda3/envs/deepenv/bin/computeMatrix"

cores=8

sample_1="Diagenode_C15410196_1_50_2M"


# compute matrices around peak summits
# to switch to SEACR, substitute summit file name and peak caller name
computeMatrix reference-point -bs 1 -S $root_dir/heatmap/bigwig/${sample_1}_one_mate_raw.bw -R $root_dir/peakCalling/MACS2/${sample_1}_rmDup_q1e-5_summits.bed --skipZeros -o $root_dir/heatmap/profiles/${sample_1}_one_mate_MACS2.mat.gz -p $cores -a 500 -b 500 --referencePoint center -bl $blacklist

computeMatrix reference-point -bs 1 -S $root_dir/resources/ENCODE/bigwig/H3K27ac_ENCSR000AKP_ds_raw.bw -R $root_dir/resources/ENCODE/peaks/H3K27ac_ENCSR000AKP_2M_summits.bed --skipZeros -o $root_dir/heatmap/profiles/H3K27ac_ENCSR000AKP_2M.mat.gz -p $cores -a 500 -b 500 --referencePoint center -bl $blacklist



# add sample labels
computeMatrixOperations relabel -m $root_dir/heatmap/profiles/${sample_1}_one_mate_MACS2.mat.gz -o $root_dir/heatmap/profiles/${sample_1}_one_mate_MACS2_label.mat.gz --groupLabels $sample_1

computeMatrixOperations relabel -m $root_dir/heatmap/profiles/H3K27ac_ENCSR000AKP_2M.mat.gz -o $root_dir/heatmap/profiles/H3K27ac_ENCSR000AKP_2M_label.mat.gz --groupLabels "ENCODE_H3K27ac"



# rbind matrices
computeMatrixOperations rbind -m $root_dir/heatmap/profiles/${sample_1}_one_mate_MACS2_label.mat.gz $root_dir/heatmap/profiles/H3K27ac_ENCSR000AKP_2M_label.mat.gz -o $root_dir/heatmap/profiles/all_samples_one_mate_MACS2.mat.gz



# plot read profiles around TSS
plotProfile -m $root_dir/heatmap/profiles/all_samples_one_mate_MACS2.mat.gz -out $root_dir/heatmap/profiles/all_samples_one_mate_MACS2_profile.png --startLabel "" --endLabel "" --yAxisLabel "Mean read count" --refPointLabel "summit"  --yMax 6 --yMin 0



