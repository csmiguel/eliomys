# align mitogenomes ( MAFFT v7.453 )
mafft data/mitogenomes_ML/mitogenomes-raxml.fasta > data/mitogenomes_ML/mito_raxml_mafft.fasta

# convert to phylip
/Applications/AMAS.py convert --in-files data/mitogenomes_ML/mito_raxml_mafft.fasta \
--in-format fasta \
-d dna \
--out-format phylip
mv mito_raxml_mafft.fasta-out.phy data/mitogenomes_ML/mito_raxml_mafft.phy

#partition scheme and models of evolution. The partitions in the .cfg file are
# created by hand after the annonatations of the mitogneomes in genbank. Codon
# positions 1,2,3 are separated, and d-loop discarded.
source activate py27
cp data/mitogenomes_ML/mito_raxml_mafft.phy data/mitogenomes_ML/partition_finder/
python /Applications/partitionfinder-2.1.1/PartitionFinder.py data/mitogenomes_ML/partition_finder --raxml --no-ml-tree --force-restart

#split dna alignment with AMAS. The goal is to eliminate all positiosn for which there is not a model of evolution, since raxml do noe allow them.
/Applications/AMAS.py split --in-files data/mitogenomes_ML/mito_raxml_mafft.phy \
--in-format phylip \
-d dna \
--out-format phylip \
-l data/mitogenomes_ML/split_amas.txt
#concatenate the resulting partitions
/Applications/AMAS.py concat -i data/mitogenomes_ML/*-out.phy \
--in-format phylip \
-d dna \
--out-format phylip \
--part-format raxml
#move files for raxml analaysis
mv concatenated.out data/mitogenomes_ML/raxml.phy
mv partitions.txt data/mitogenomes_ML/raxml_partitions.txt

# Maximum Likelihood tree
p=$(pwd)
raxml -f a -m GTRGAMMA -p 12345 -x 12345 -N 100 \
-s $p/data/mitogenomes_ML/raxml.phy -n mito.tree \
-T2 -w $p/output -q $p/data/mitogenomes_ML/raxml_partitions.txt
