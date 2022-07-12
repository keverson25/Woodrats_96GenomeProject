cd home/keverson/96Neo_FilteredVCFs

### use plink to extract only SNPs that are in LD
plink --vcf Neo96_MergedAutosomes.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 100 1000 0.1 --out Neo96_MergedAutosomes_4PCA

### use plink to calculate a PCA using only SNPs in LD
plink --vcf Neo96_MergedAutosomes.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract Neo96_MergedAutosomes_4PCA.prune.in --make-bed --pca --out Neo96_MergedAutosomes_PCA

### use plink to calculate a PCA using only SNPs in LD and only bryanti individuals
plink --vcf Neo96_MergedAutosomes.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --remove-fam ../GWAS/lepida2drop.txt --extract Neo96_MergedAutosomes_4PCA.prune.in --make-bed --pca --out Neo96_MergedAutosomes_BryOnlyPCA
