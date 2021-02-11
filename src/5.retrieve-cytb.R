###.............................................................................
# (c) Miguel Camacho Sánchez
# miguelcamachosanchez@gmail.com // miguelcamachosanchez.weebly.com
# https://scholar.google.co.uk/citations?user=1M02-S4AAAAJ&hl=en
# January 2021
###.............................................................................
#GOAL: retrieve cytb from genbank of Eliomys quercinus
#PROJECT: Eliomys
###.............................................................................
library(rentrez)

#retrieve ids from genbank with eliomys cytb
eliom <- rentrez::entrez_search("nucleotide",
    term = "eliomys quercinus cytochrome b",
    retmode = "xml", retmax = 1000)

#vector with E. melanurus. To remove:
emela <- c("372285226", "372285228", "372285230", "372285232", "4127830")
ids <- eliom$ids[-which(eliom$ids %in% emela)]

#fetch fasta sequences
eliom_fetch <-
  rentrez::entrez_fetch(db = "nucleotide",
                        id = ids,
                        rettype = "fasta")
#write fasta
write(eliom_fetch, file = "data/intermediate/eliomys_cytb.fasta")
