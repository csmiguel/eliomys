
#!bin/bash
#index reference
bwa index data/intermediate/eliomys-reference.fasta
#map to novoplasty reference
ls data/raw/*fastq.gz | sed -e 's|.*/||;s|\..*$||' | sort | uniq | \
while read sample
  do
  bwa mem data/intermediate/eliomys-reference.fasta \
   data/intermediate/"$sample".cutadapt.1.fastq.gz \
   data/intermediate/"$sample".cutadapt.2.fastq.gz > \
   data/intermediate/"$sample".sam
done

#remove duplicates
ls data/raw/*fastq.gz | sed -e 's|.*/||;s|\..*$||' | sort | uniq | \
while read sample
  do
 /usr/local/bin/samtools view -Shu -F4 -q40 data/intermediate/"$sample".sam > data/intermediate/"$sample".bam
 /usr/local/bin/samtools sort -o data/intermediate/"$sample".sorted.bam data/intermediate/"$sample".bam
 /usr/local/bin/samtools rmdup -S data/intermediate/"$sample".sorted.bam data/intermediate/"$sample".rmdup.bam
done
