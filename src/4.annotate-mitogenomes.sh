#!bin/bash
#annotate the mitogenomes
cd data/intermediate
seqkit seq -ni mitogenomes-eliomys.fasta | while read sample
do
cat mitogenomes-eliomys.fasta | seqkit grep -r -p "$sample" > temp.fasta
docker run -v $PWD:/project  --rm guanliangmeng/mitoz:2.4-alpha \
  python3 /app/release_MitoZ_v2.4-alpha/MitoZ.py annotate \
  --genetic_code 2 --clade Chordata \
  --outprefix "$sample" --thread_number 2 \
  --fastafile temp.fasta
done
rm temp.fasta
cd ../..
