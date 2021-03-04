#!bin/bash
#run raxml
p=$(pwd)
raxml -f a -m GTRGAMMA -p 12345 -x 12345 -# autoMRE \
-s $p/data/intermediate/phylo.phy \
 -n cytb -T2 -w $p/data/intermediate/raxml \
 -q $p/data/intermediate/raxml/partitions.txt
