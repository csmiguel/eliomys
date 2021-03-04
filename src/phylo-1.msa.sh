#!bin/bash

cat data/raw/HE614010.fasta  \
data/raw/AJ225117.fasta \
data/raw/AJ225031.fasta \
data/raw/AJ225116.fasta \
data/intermediate/all-cytb.fasta > data/intermediate/phylo-all.fasta

#msa
mafft --auto data/intermediate/phylo-all.fasta > data/intermediate/phylo-all.mafft.fasta

#trim little informative phylogenetic positions, by codon
/Applications/Gblocks data/intermediate/phylo-all.mafft.fasta -t=c -b5=h

#convert to phylip
cd data/intermediate
/Applications/AMAS.py convert -u phylip -f fasta -d dna -i phylo-all.mafft.fasta-gb
cd ../..

#change name
mv data/intermediate/phylo-all.mafft.fasta-gb-out.phy data/intermediate/phylo.phy
