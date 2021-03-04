#!bin/bash
mafft --auto data/intermediate/all-cytb.fasta > data/intermediate/eliomys.mafft.fasta

#remove residues with more than 0.5 of missing data
trimal -in data/intermediate/eliomys.mafft.fasta -out data/intermediate/temp.fasta -htmlout data/intermediate/temp.html -gt 0.5
#remve sequences which do not overlap at least 70% with the others
trimal -in data/intermediate/temp.fasta -out data/intermediate/temp2.fasta -htmlout data/intermediate/temp2.html -resoverlap 0.7 -seqoverlap 70
#remove sites with any gaps
trimal -in data/intermediate/temp2.fasta -out data/intermediate/eliomys.filt.fasta -htmlout data/intermediate/eliomys.filt.html -nogaps

#convert from fasta to nexus
cd data/intermediate
/Applications/AMAS.py convert -u nexus -f fasta -d dna -i eliomys.filt.fasta
cd ../..
