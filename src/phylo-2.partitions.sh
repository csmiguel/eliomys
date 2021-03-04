#!bin/bash
#create dir
mkdir data/intermediate/partitionfinder
#edit by hand config file data/intermediate/partitionfinder/partition_finder.cfg
cp data/intermediate/phylo.phy data/intermediate/partitionfinder/phylo.phy

#determine partition scheme
source activate py27
python /Applications/partitionfinder-2.1.1/PartitionFinder.py data/intermediate/partitionfinder --raxml
source deactivate
