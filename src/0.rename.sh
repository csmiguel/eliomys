#!bin/bash
#this script is run first and not included in the open repository.
#it renames the fastq with the r
ls data/raw/*_[1-2].fastq.gz |  while read fq
do
 dnaext=$(basename $fq | cut -d_ -f1)
 sample=$(cat src/rename-fastq | grep $dnaext | awk '{print $2}')
 newname=$(echo $fq | sed "s|mc.*\([1-2].fastq.gz\)|$sample.\1|")
 mv $fq $newname
done
