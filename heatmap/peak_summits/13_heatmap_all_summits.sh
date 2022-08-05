#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mem=16gb

module load anaconda3/personal
source activate deepenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
plotHeatmap="$HOME/anaconda3/envs/deepenv/bin/plotHeatmap"
computeMatrix="$HOME/anaconda3/envs/deepenv/bin/computeMatrix"
cores=8

#sample_name="Diagenode_C15410196_1_50_2M"
sample_name="CST9733_1_100_H3K27me3_2M"

#threshold="0.01"
threshold="0.1"



# SEACR
computeMatrix reference-point -S $root_dir/heatmap/bigwig/${sample_name}_one_mate_raw.bw -R $root_dir/peakCalling/SEACR/${sample_name}_seacr_top${threshold}_peaks.summitRegion.bed --skipZeros -o $root_dir/heatmap/peak_summits/${sample_name}_one_mate_SEACR.mat.gz -p $cores -a 3000 -b 3000 --referencePoint center

plotHeatmap --colorMap magma -m $root_dir/heatmap/peak_summits/${sample_name}_one_mate_SEACR.mat.gz -out $root_dir/heatmap/peak_summits/${sample_name}_one_mate_SEACR_heatmap.png --sortUsing sum --startLabel "Peak Start" --endLabel "Peak End" --xAxisLabel "" --regionsLabel "Peaks" --samplesLabel ${sample_name}


# MACS2
#computeMatrix reference-point -S $root_dir/heatmap/bigwig/${sample_name}_one_mate_raw.bw -R $root_dir/peakCalling/MACS2/${sample_name}_rmDup_q1e-5_summits.bed --skipZeros -o $root_dir/heatmap/peak_summits/${sample_name}_one_mate_MACS2.mat.gz -p $cores -a 3000 -b 3000 --referencePoint center

#plotHeatmap --colorMap magma -m $root_dir/heatmap/peak_summits/${sample_name}_one_mate_MACS2.mat.gz -out $root_dir/heatmap/peak_summits/${sample_name}_one_mate_MACS2_heatmap.png --sortUsing sum --startLabel "Peak Start" --endLabel "Peak End" --xAxisLabel "" --regionsLabel "Peaks" --samplesLabel ${sample_name}


# ENCODE
#computeMatrix reference-point -S $root_dir/resources/ENCODE/bigwig/H3K27ac_ENCSR000AKP_ds_raw.bw -R $root_dir/resources/ENCODE/peaks/H3K27ac_ENCSR000AKP_2M_summits.bed --skipZeros -o $root_dir/heatmap/peak_summits/H3K27ac_ENCSR000AKP_2M_MACS2.mat.gz -p $cores -a 3000 -b 3000 --referencePoint center

#plotHeatmap --colorMap magma -m $root_dir/heatmap/peak_summits/H3K27ac_ENCSR000AKP_2M_MACS2.mat.gz -out $root_dir/heatmap/peak_summits/H3K27ac_ENCSR000AKP_2M_MACS2_heatmap.png --sortUsing sum --startLabel "Peak Start" --endLabel "Peak End" --xAxisLabel "" --regionsLabel "Peaks" --samplesLabel "ENCODE_H3K27ac"
