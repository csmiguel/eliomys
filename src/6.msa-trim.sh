###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# January 2021
###.............................................................................
#GOAL: retrieve cytb from genbank of Eliomys quercinus
#PROJECT: Eliomys
###.............................................................................
mafft --auto data/intermediate/eliomys_cytb.fasta > data/intermediate/eliomys.mafft.fasta

#
trimal -in data/intermediate/eliomys.mafft.fasta -out data/intermediate/temp.fasta -htmlout data/intermediate/temp.html -gt 0.5
trimal -in data/intermediate/temp.fasta -out data/intermediate/temp2.fasta -htmlout data/intermediate/temp2.html -resoverlap 0.7 -seqoverlap 70
trimal -in data/intermediate/temp2.fasta -out data/intermediate/eliomys.filt.fasta -htmlout data/intermediate/eliomys.filt.html -nogaps

cd data/intermediate
/Applications/AMAS.py convert -u nexus -f fasta -d dna -i eliomys.filt.fasta
