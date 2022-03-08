# (c) Miguel Camacho Sánchez
# https://orcid.org/0000-0002-6385-7963
# github.com/csmiguel/eliomys
# create meta data table
meta <- data.frame(
  stringsAsFactors = FALSE,
  sample = c("AJ225030","FM164278","FR848957",
             "FR848958","GQ453668","GQ453669","HE611090","HE611091",
             "HE611092","HE611093","HE613976","HE613977","HE613978",
             "HE613979","HE613980","HE613981","HE613982","HE613983",
             "HE613985","HE613986","HE613987","HE613988",
             "HE613989","HE613990","HE613991","HE613992","HE613993",
             "HE613994","HE613995","HE613996","HE613997","HE613998",
             "HE613999","HE614000","HE614001","HE614002","HE614003",
             "HE614004","HE614005","HE614006","HE614007",
             "HE614008","JX457812","JX457813","JX457814","JX457815",
             "JX457816"),
  country = c("na", "belgium","na","na","italy",
              "italy","france","france","france","france",
              "france","france","italy","italy","italy","italy","italy",
              "italy","france","france","france","france",
              "france","Iberia","Iberia","Iberia","Iberia","croatia",
              "italy","italy","italy","italy","italy","italy",
              "italy","austria","belgium","belgium","france","france",
              "france","germany","Iberia","Iberia","Iberia",
              "Iberia","Iberia")
)

table(meta) %>% as.data.frame.matrix() %>%
  write.csv(file = "data/raw/traitblock", sep = ",", quote = F)