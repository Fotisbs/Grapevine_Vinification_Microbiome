                                                              ##Bar Plots analysis##

##load phyloseq object for fungi, (the XXXXXX.RDS File from the construcrion of the phyloseq object raw counts)##

fungi_vinification_Annotated   

###Merging 4th Stage replicates###
fungi_vinification_Annotated.4thStage <- merge_samples(fungi_vinification_Annotated, "stage_replicate")

fungi_vinification_Annotated.4thStage <- prune_taxa(taxa_sums(fungi_vinification_Annotated.4thStage)>0,fungi_vinification_Annotated.4thStage)

View(data.frame(sample_data(fungi_vinification_Annotated.4thStage)))

write.table(data.frame(sample_data(fungi_vinification_Annotated.4thStage)), file="fungi_vinification_Annotated.4thStage.txt", quote = F,col.names = NA, sep="\t")

SampleDataNew67 <- read.table("fungi_vinification_Annotated.4thStage.txt", header=T,sep = "\t",row.names = 1)

sample_data(fungi_vinification_Annotated.4thStage) <- SampleDataNew67

fungi_vinification_Annotated.4thStage

View(data.frame(sample_data(fungi_vinification_Annotated.4thStage)))

###RA % Both cultivars
fungi_vinification_Annotated.4thStage_100 <- transform_sample_counts(fungi_vinification_Annotated.4thStage, function(OTU) 100*OTU/sum(OTU))

saveRDS(fungi_vinification_Annotated.4thStage_100, file = "fungi_vinification_Annotated.4thStage_100.RDS")

fungi_vinification_Annotated.4thStage_100

##top 12 ASVs## 
myTaxa11_fungi_vinification_Annotated.4thStage_100
 <- names(sort(taxa_sums(fungi_vinification_Annotated.4thStage_100
), decreasing = TRUE)[1:12])  

Top11_fungi_vinification_Annotated.4thStage_100
 <- prune_taxa(myTaxa11_fungi_vinification_Annotated.4thStage_100
, fungi_vinification_Annotated.4thStage_100
)

taxa_names(Top11_fungi_vinification_Annotated.4thStage_100
)

- - - - - - - -- - -ASVs plot -  -- - -- - --
  
mytax11_fungi_vinification_Annotated.4thStage_100
 <- data.frame(tax_table(Top11_fungi_vinification_Annotated.4thStage_100
), stringsAsFactors = F)

# For ITS - Remove letter from taxonomy
for (i in c(1:nrow(mytax11_fungi_vinification_Annotated.4thStage_100
))) {
  for(j in c(1:ncol(mytax11_fungi_vinification_Annotated.4thStage_100
))) {
    mytax11_fungi_vinification_Annotated.4thStage_100
[i,j] <- gsub("[a-z]__","",mytax11_fungi_vinification_Annotated.4thStage_100
[i,j])
  }
}

mytxplot11_fungi_vinification_Annotated.4thStage_100
 <- data.frame(OTU = row.names(mytax11_fungi_vinification_Annotated.4thStage_100
), 
                                        txplt = paste(row.names(mytax11_fungi_vinification_Annotated.4thStage_100
), " ", mytax11_fungi_vinification_Annotated.4thStage_100
$Genus,  ":", mytax11_fungi_vinification_Annotated.4thStage_100
$Species,  sep = ""))

row.names(mytxplot11_fungi_vinification_Annotated.4thStage_100
) <- mytxplot11_fungi_vinification_Annotated.4thStage_100
$OTU

taxa_names(Top11_fungi_vinification_Annotated.4thStage_100
) <- mytxplot11_fungi_vinification_Annotated.4thStage_100
[taxa_names(Top11_fungi_vinification_Annotated.4thStage_100
),"txplt"]

pdf(file = "L.pdf", width = 14, height = 7)
plot_bar(Top11_fungi_vinification_Annotated.4thStage_100
, x="stage", fill="OTU", title = "") + facet_grid(cols = vars(terroir_vinification), rows = vars(year)) + geom_col() + scale_fill_manual(values = mycols)
dev.off()

