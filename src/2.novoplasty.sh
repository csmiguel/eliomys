#!bin/bash
# (c) Miguel Camacho Sánchez
# https://orcid.org/0000-0002-6385-7963
# github.com/csmiguel/eliomys
#Mitogenome assembly with Novoplasty3 to create a reference mitogenome for Eliomys.
#I pooled F and R trimmed files to increase coverage and be able to reconstruct
# the control region. Previous test with the individual files failed to assemble
# correctly the control region. By the time I created this script the closest mitogenome
# in genbank was from Glis glis. By the time of submitting the paper there is
# a mitogenome from E. quercinus.
#As seed I used cytb from Eliomys quercinus from genebank.
#the output is an unique contig.

#create pooled fastq with all samples
mkdir data/intermediate/novoplastytemp
cp data/intermediate/*cutadapt*fastq.gz data/intermediate/novoplastytemp
find data/intermediate/novoplastytemp/*fastq.gz | xargs gunzip
cat data/intermediate/novoplastytemp/*1.fastq > data/intermediate/novoplastytemp/1.fastq
cat data/intermediate/novoplastytemp/*2.fastq > data/intermediate/novoplastytemp/2.fastq
rm data/intermediate/novoplastytemp/*cutadapt*

#run novoplasty
perl src/NOVOPlasty3.7.pl -c src/test.novoplasty-config.txt

rm contigs*
mv Circularized_assembly* data/intermediate/eliomys-reference.fasta
mv log_* output/
#I then manually set the coordinate 1 of the reference mitogenome to start at
# position 1 of tRNA-phe
