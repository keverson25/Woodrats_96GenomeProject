### use vcftools to do further filtering on each of Brian Simison’s pre-filtered vcf files; 
### remove indels, thin to 1 SNP every 10,000 bp to account for LD, and remove any singleton variants

vcftools --gzvcf Brians_filtered.vcf.gz --recode --recode-INFO-all --remove-indels –maf 0.05 –max-maf 0.95 –-thin 10000 -Ob -o 96Neo_FilteredVCFs/Neo96_Chr[#]_filtKME.recode.vcf.gz

### repeat for each chromosome's vcf file

### Merge the thinned vcfs from each chromosome together 

bcftools concat 96Neo_FilteredVCFs/*.vcf.gz > 96Neo_FilteredVCFs/Neo96_MergedAutosomes.vcf

### Use the huge merged VCF file as the input for alstructure, which is run within the wrapper program structure_threader:
### note: a .ind file (structure format) is required for this 

structure_threader run -i 96Neo_FilteredVCFs/Neo96_MergedAutosomes.vcf -o alstructure_mergedAutosomeResults -als /home/keverson/.local/bin/alstructure_wrapper.R -K 5 -t 5 --ind 96Neotoma.indfile
