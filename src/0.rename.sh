#!bin/bash
########
# (c) Miguel Camacho Sánchez
# https://orcid.org/0000-0002-6385-7963
# github.com/csmiguel/eliomys
########
#this script is run once
#renames fastq files with clean sample names
ls data/raw/*_[1-2].fastq.gz |  while read fq
do
 dnaext=$(basename $fq | cut -d_ -f1)
 sample=$(cat src/rename-fastq | grep $dnaext | awk '{print $2}')
 newname=$(echo $fq | sed "s|mc.*\([1-2].fastq.gz\)|$sample.\1|")
 mv $fq $newname
done
