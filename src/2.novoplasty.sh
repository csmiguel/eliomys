#!bin/bash
#I created a F and Reverse files with all trimmed (cutadapt) sequences from all Eliomys samples.
#in that way novoplasty has more data to generate a unique mitochondrial contig.
#as seed I used cytb from Eliomys from genebank.
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
mv log_* data/intermediate
#I then manually copy-paste the sequence in the contig to start with tRNA-phe
