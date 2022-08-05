# CUT&Tag benchmarking and analysis

This repository holds code used to carry out benchmarking and analysis of CUT&Tag against ENCODE ChIP-seq, as shown in our preprint ("CUT&Tag recovers up to half of ENCODE ChIP-seq peaks"; doi: https://doi.org/10.1101/2022.03.30.486382).  

The analysis consists of two main parts:
1) Pre-processing (adapter trimming, alignment, peak calling, etc.) using Linux command line scripts
2) Downstream processing in R

The demo was carried out on two real samples, Diagenode C15410196 (1:50) and CST9733, starting from fastq files. These files are too large to be hosted here but can be downloaded from the European Nucleotide Archive (sample accessions SAMN27024067 and SAMN27024069, respectively). All code required for processing and analysis is enclosed, and presented in a defined order where appropriate. Other outputs and smaller intermediate files have also been included where possible. The scripts assume a particular directory structure but note that base paths will need to be amended. A complete analysis may take upwards of 12 hours.  


The following command line tools were used:

- Cutadapt v3.3
- TrimGalore v0.6.6
- Bowtie v2.2.9
- Picard v2.6.0
- samtools v1.3.1
- bedtools v2.30.0
- deeptools v3.5.1
- SEACR v1.3
- MACS2 v2.1.4
- HOMER v4.10


Required R packages can be found in the session information provided in the html file with downstream analysis. Note that this analysis pipeline is now available in the form of the EpiCompare R package (https://github.com/neurogenomics/EpiCompare).


### References

CUT&Tag recovers up to half of ENCODE ChIP-seq peaks
Di Hu, Leyla Abbasova, Brian M Schilder, Alexi Nott, Nathan G Skene, Sarah J Marzi
bioRxiv 2022.03.30.486382; doi: https://doi.org/10.1101/2022.03.30.486382

EpiCompare: R package for the comparison and quality control of epigenomic peak files (2022)
Sera Choi, Brian M. Schilder, Leyla Abbasova, Alan E. Murphy, Nathan G. Skene
bioRxiv 2022.07.22.501149; doi: https://doi.org/10.1101/2022.07.22.501149

