#!bin/bash
########
# (c) Miguel Camacho Sánchez
# https://orcid.org/0000-0002-6385-7963
# github.com/csmiguel/eliomys
########
#get samples
ls data/raw/*fastq.gz | sed -e 's|.*/||;s|\..*$||' | sort | uniq | \
while read sample
do
  #trim adapters
  cutadapt -a AGATCGGAAGAGC -A AGATCGGAAGAGC -e 0.16 -m 30 -q 10 \
   -o data/intermediate/"$sample".cutadapt.1.fastq.gz \
   -p data/intermediate/"$sample".cutadapt.2.fastq.gz \
   data/raw/"$sample".1.fastq.gz \
   data/raw/"$sample".2.fastq.gz  >> data/intermediate/cutadapt.log
done
