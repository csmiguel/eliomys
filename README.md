[![DOI](https://zenodo.org/badge/337977089.svg)](https://zenodo.org/badge/latestdoi/337977089)

# Complete mitogenomes of the garden dormouse (_Eliomys quercinus_)

Forcina, G., Camacho–Sanchez, M., Cornellas, A., Leonard, J. A., 2022. Complete mitogenomes reveal limited genetic variability in the garden dormouse *Eliomys quercinus* of the Iberian Peninsula. **Animal Biodiversity and Conservation**

## Mitogenome assembly and annotation
Adapter trimming and minimal quality filtering on the 3' end were performed with [cutadapt 2.10](https://doi.org/10.14806/ej.17.1.200) using [script1](src/1.trim-fastq.sh).
A reference mitogenome for _Eliomys quercinus_ was created with [NOVOPlasty3.7](https://doi.org/10.1093/nar/gkw955) using [script2](src/2.novoplasty.sh). The four samples were pooled. NOVOPlasty is able to assemble de-novo mitogenomes using a seed sequence. I used a cytochrome b [GQ453669](data/raw/GQ453669.fasta) from *E. quercinus*. NOVOPlasty was able to reconstruct a single [contig](output/log_eliomys_novoplasty.txt) with the expected size of the mitogenome.

Individual samples of *Eliomys* were mapped to the reference mitogenome using [BWA mem 0.7.12-r1039](https://arxiv.org/abs/1303.3997). [SAMtools 1.3](https://doi.org/10.1093/bioinformatics/btp352) (using htslib 1.3), was used to discard reads with quality mapping below 40 and remove PCR duplicates, with [script3](src/3.assemble.sh).

Mitogenomes were annotated with [MITOS2 webserver](http://mitos.bioinf.uni-leipzig.de/index.py). [MITOS](https://doi.org/10.1016/j.ympev.2012.08.023) provided better annotations compared to MitoZ. The annotations have been manually curated after comparing them with the NCBI staff-curated mitochondrial genomes of two close species: _Muscardinus avellanarius_ - [NC_050264](https://www.ncbi.nlm.nih.gov/nuccore/NC_050264) and _Glis glis_ - [NC_001892.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_001892).

## Reconstruction of haplotype networks using cytochrome b
All *cytochrome b* sequences from _E. quercinus_ available in GenBank were retrieved with the [rentrez]( https://doi.org/10.7287/peerj.preprints.3179v2) R package using [script5](src/5.retrieve-cytb.R). They were combined with assembled cytb sequences using [script6](src/6.multifasta-cytb.sh) and written to a fasta.

Using [script7](src/7.msa-trim.sh), *cytb* sequences were aligned using [mafft v7.453](https://doi.org/10.1093/molbev/mst010). The resulting MSA was trimmed using [trimAl v1.4.rev15 build 2013-12-17](https://doi.org/10.1093/bioinformatics/btp348) to remove sequences and positions in the MSA to maximize the amount of information. The MSA was converted to nexus using [AMAS](https://doi.org/10.7717/peerj.1660).
Final haplotype networks were reconstructed with [PopArt](https://doi.org/10.1111/2041-210X.12410), using the TCS algorithm. The msa NEXUS file is available in [output/cyb-network.nex](output/cyb-network.nex).

## Phylogenetic reconstructions
A maximum likelihood tree was reconstructed with 1st and 2nd codon positions of protein-coding genes from all mitogenomes of Gliridae available in GenBank. Initial trees with Sciuridae included lots of saturated positions. I tried then a ML tree with only dormice and *Glis glis* as sister to all of them, as in [Upham et al. 2019](https://doi.org/10.1371/journal.pbio.3000494). The [final tree](output/RAxML_bipartitions.mito.tree) was produced following [these steps](src/mitogenomes_ML.txt) and [this DNA alignment](data/mitogenomes_ML/raxml.phy).

## Annotated mitochondrial genomes
Mitogenomes were deposited in GenBank under the BioProject [PRJNA727082](https://www.ncbi.nlm.nih.gov/bioproject/727082): Genetic resources for small mammals.

| sample            | species           | BioSample    | accession no.                                             | SRA         |
|-------------------|-------------------|--------------|-----------------------------------------------------------|-------------|
| EBD 2003.101.123M | Eliomys quercinus | SAMN19006130 | [MZ130252](https://www.ncbi.nlm.nih.gov/nuccore/MZ130252) | SRR14415825 |
| EBD 2011.020.017M | Eliomys quercinus | SAMN19006131 | [MZ130253](https://www.ncbi.nlm.nih.gov/nuccore/MZ130253) | SRR14415824 |
| EBD 2013.075.014M | Eliomys quercinus | SAMN19006132 | [MZ130255](https://www.ncbi.nlm.nih.gov/nuccore/MZ130255) | SRR14415823 |
| EBD 2012.022.013M | Eliomys quercinus | SAMN19006133 | [MZ130254](https://www.ncbi.nlm.nih.gov/nuccore/MZ130254) | SRR14415822 |
