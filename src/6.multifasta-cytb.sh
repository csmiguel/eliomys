#!bin/bash
########
# (c) Miguel Camacho Sánchez
# https://orcid.org/0000-0002-6385-7963
# github.com/csmiguel/eliomys
########
#create multifasta with cytb from genbank plus cytb from assembled mitogenomes
#1. create multifasta from assembled mitogenomes
rm data/intermediate/cytb-assembled.fasta

ls data/intermediate/*result/*cds | while read fasta
do
  cat $fasta | seqkit grep -r -p CYTB >> data/intermediate/cytb-assembled.fasta
done

#2. merge genbank plus assembled CYTB (and clean names)
# and remove sequences with no associated locality

cat data/intermediate/cytb-assembled.fasta \
 data/intermediate/genbank_cytb.fasta | \
 sed -e 's|\..*$||;s|;.*$||'| \
 seqkit grep -r -p AJ225030 -p FR848957 -p FR848958 -v \
 > data/intermediate/all-cytb.fasta
