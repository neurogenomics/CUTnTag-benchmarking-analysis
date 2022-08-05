#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=32:mem=64gb

module load anaconda3/personal
source activate deepenv

root_dir="/rds/general/user/la420/projects/neurogenomics-lab/live/Projects/CUT_n_TAG/test_data"
plotHeatmap="$HOME/anaconda3/envs/deepenv/bin/plotHeatmap"
computeMatrix="$HOME/anaconda3/envs/deepenv/bin/computeMatrix"
cores=32

sample_1="Diagenode_C15410196_1_50_2M"
sample_2="CST9733_1_100_H3K27me3_2M"


computeMatrix scale-regions -S $root_dir/heatmap/bigwig/${sample_1}_one_mate_raw.bw \
                               $root_dir/heatmap/bigwig/${sample_2}_one_mate_raw.bw \
                               $root_dir/resources/ENCODE/bigwig/H3K27ac_ENCSR000AKP_ds_raw.bw \
                              -R $root_dir/resources/hg19/hg19.ncbiRefSeq.gtf.gz \
                              --beforeRegionStartLength 3000 \
                              --regionBodyLength 5000 \
                              --afterRegionStartLength 3000 \
                              --skipZeros \
                              -o $root_dir/heatmap/transcription_units/matrix_gene_one_mate.mat.gz \
                              -p $cores

# plot heatmap
plotHeatmap --colorMap magma -m $root_dir/heatmap/transcription_units/matrix_gene_one_mate.mat.gz -out $root_dir/heatmap/transcription_units/heatmap_transcription_units_one_mate.png --sortUsing sum --samplesLabel $sample_1 $sample_2 $sample_3 "ENCODE_H3K27ac"


