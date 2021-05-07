rm -rf data/intermediate/*tmp*
#create file with annotations
find data/intermediate -name *fa.tbl | xargs cat > genbank_submission/annotations.tbl

#edit by hand annotations.tbl to replace "Aresidues to the mRNA\n" by "A residues to the mRNA\n\t\t\ttransl_except\t(pos:xxx,aa:TERM)\n"

#cp mitogenomes file
cp data/intermediate/mitogenomes-eliomys.fasta genbank_submission/mitogenomes.fsa

cd genbank_submission
mac.tbl2asn -t template.sbt -f mitos2.tbl -i mitogenomes.fsa -V bv -a s2
cd --
