library(tidyverse)

setwd("/home/keverson/96Neo_FilteredVCFs")

pca<-read_table2("Neo96_MergedAutosomes_PCA.eigenvec", col_names=F)
eigenval<-scan("Neo96_MergedAutosomes_PCA.eigenval")

### cleanup
# remove a nuisance column
pca<-pca[,-1]
# set names
names(pca)[1]<-"ind"
names(pca)[2:ncol(pca)]<-paste0("PC",1:(ncol(pca)-1))

### sort out individual species
spp <- rep(NA, length(pca$ind))
spp[grep("Nbry", pca$ind)]<-"bryanti"
spp[grep("Nlep", pca$ind)]<-"lepida"
spp[grep("Nbry_MZ202520", pca$ind)]<-"mismatchedBry" ## do each of these manually

### remake data frame
pca<-as.tibble(data.frame(pca,spp))


###convert eigenvalues to percentage explained
pve <- data.frame(PC=1:20, pve=eigenval/sum(eigenval)*100)

a<-ggplot(pve, aes(PC, pve)) + geom_bar(stat="identity")
a + ylab("Percentage variance explained") + theme_light()
cumsum(pve$pve)

# plot pca
b <- ggplot(pca, aes(PC1, PC2, col = spp)) + geom_point(size = 3)
b <- b + coord_equal() + theme_light()
b + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))



# lepidaRemoved -----------------------------------------------------------


BryOnlyPCA<-read_table2("Neo96_MergedAutosomes_BryOnlyPCA.eigenvec", col_names=F)
BryOnlyEigenval<-scan("Neo96_MergedAutosomes_BryOnlyPCA.eigenval")

### cleanup
# remove a nuisance column
BryOnlyPCA<-BryOnlyPCA[,-1]
# set names
names(BryOnlyPCA)[1]<-"ind"
names(BryOnlyPCA)[2:ncol(BryOnlyPCA)]<-paste0("PC",1:(ncol(BryOnlyPCA)-1))

### sort out individual species
BryOnlySpp <- spp[1:69]

### remake data frame
BryOnlyPCA<-as.tibble(data.frame(BryOnlyPCA,BryOnlySpp))


###convert eigenvalues to percentage explained
BryOnlyPve <- data.frame(PC=1:20, pve=BryOnlyEigenval/sum(BryOnlyEigenval)*100)

a<-ggplot(BryOnlyPve, aes(PC, pve)) + geom_bar(stat="identity")
a + ylab("Percentage variance explained") + theme_light()
cumsum(BryOnlyPve$pve)

# plot pca
b <- ggplot(BryOnlyPCA, aes(PC1, PC2, col = BryOnlySpp)) + geom_point(size = 3)
b <- b + coord_equal() + theme_light()
b + xlab(paste0("PC1 (", signif(BryOnlyPve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(BryOnlyPve$pve[2], 3), "%)"))

b <- ggplot(BryOnlyPCA, aes(PC2, PC3, col = BryOnlySpp)) + geom_point(size = 3)
b <- b + coord_equal() + theme_light()
b + xlab(paste0("PC2 (", signif(BryOnlyPve$pve[2], 3), "%)")) + ylab(paste0("PC3 (", signif(BryOnlyPve$pve[3], 3), "%)"))
