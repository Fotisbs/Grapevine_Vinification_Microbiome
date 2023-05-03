                                                 ##PERMANOVA‐based variation partitioning analysis######
##load package vegan and adonis function##
library(vegan)
library(pairwiseAdonis)
      
##load phyloseq object for fungi, (the XXXXXX.RDS File from the construcrion of the phyloseq object raw counts)##
fungi_vinification_Annotated   

##PERMANOVA‐based variation partitioning analysis must be applied to both vinification cultivars collectively and for each variety separately## 
##ALL VARIETIES COLLECTIVELY##
##transform phyloseq object raw counts to relative abundance (100%)##
fungi_vinification_Annotated100 <- transform_sample_counts(fungi_vinification_Annotated, function(OTU) 100*OTU/sum(OTU))

##Both Cultivars##
##PERMANOVA using Bray-Curtis dissimilarity index##
mypermanovafungi_vinification_Annotated100_Both <- adonis(fungi_vinification_Annotated100@otu_table ~ year + variety + terroir + vinification + stage, method = "bray", data = data.frame(fungi_vinification_Annotated100@sam_data))                              

##All Varieties##
##export the statistics## 
mypermanovafungi_vinification_Annotated100_Both                              
                               
                               
##EACH CULTIVAR SEPARATELY##
##Subset DataSet to each cultivar and perform PERMANOVA analysis##         
##Subset Roditis samples##
                                                         
fungi_vinification_Annotated_Roditis <- subset_samples(fungi_vinification_Annotated, variety=="Roditis")
fungi_vinification_Annotated_Roditis <- prune_taxa(taxa_sums(fungi_vinification_Annotated_Roditis)>0,fungi_vinification_Annotated_Roditis)

##Roditis##
##transform phyloseq object raw counts to relative abundance (100%)##
fungi_vinification_Annotated_Roditis100 <- transform_sample_counts(fungi_vinification_Annotated_Roditis, function(OTU) 100*OTU/sum(OTU))

##Roditis##
##PERMANOVA using Bray-Curtis dissimilarity index##
mypermanovafungi_vinification_Annotated_Roditis100 <- adonis(fungi_vinification_Annotated_Roditis100@otu_table ~ year + terroir + vinification + stage, method = "bray", data = data.frame(fungi_vinification_Annotated100_Roditis100@sam_data))
##Roditis##
##export the statistics##
mypermanovafungi_vinification_Annotated_Roditis100

##Subset Sideritis samples##
fungi_vinification_Annotated_Sideritis <- subset_samples(fungi_vinification_Annotated, variety=="Sideritis")
fungi_vinification_Annotated_Sideritis <- prune_taxa(taxa_sums(fungi_vinification_Annotated_Sideritis)>0,fungi_vinification_Annotated_Sideritis)

##Sideritis##
##transform phyloseq object raw counts to relative abundance (100%)##
fungi_vinification_Annotated_Sideritis100 <- transform_sample_counts(fungi_vinification_Annotated_Sideritis, function(OTU) 100*OTU/sum(OTU))

##Sideritis##
##PERMANOVA using Bray-Curtis dissimilarity index##
mypermanovafungi_vinification_Annotated_Sideritis100 <- adonis(fungi_vinification_Annotated_Sideritis100@otu_table ~ year + terroir + vinification + stage, method = "bray", data = data.frame(fungi_vinification_Annotated_Sideritis100@sam_data))
##Sideritis##
##export the statistics##
mypermanovafungi_vinification_Annotated_Sideritis100











