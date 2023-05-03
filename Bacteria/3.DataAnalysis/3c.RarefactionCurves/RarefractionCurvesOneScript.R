MUST_Fungi_RIS3_2020.2021.C.A_Merged.An

MUST_Fungi_RIS3_2020.2021.C.A_Merged.An_100 <- prune_taxa(taxa_sums(MUST_Fungi_RIS3_2020.2021.C.A_Merged.An_100)>0,MUST_Fungi_RIS3_2020.2021.C.A_Merged.An_100)



MUST_Fungi_RIS3_2020.2021.C.A_Merged.An


a <- data.frame(t(otu_table(MUST_Fungi_RIS3_2020.2021.C.A_Merged.An)))



rarecurve(a, step=20, cex=0.5)


rarecurve(t(otu_table(MUST_Fungi_RIS3_2020.2021.C.A_Merged.An)), step=20, labels = F)


rarecurve(t(otu_table(MUST_Fungi_Sideritis_2020.2021)), step=20, label = F, sample) 


rarecurve(t(otu_table(MUST_Fungi_RIS3_2020.2021.C.A_Merged.An)), step=50, cex=0.5, label = F, xlim=c(0,1500))

rarecurve(t(otu_table(MUST_Fungi_RIS3_2020.2021.C.A_Merged.An)), step=50, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,))

rarecurve(t(otu_table(MUST_Fungi_RIS3_2020.2021.C.A_Merged.An)), cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,120))

###
rarecurve(t(otu_table(MUST_Fungi_RIS3_2020.2021.Cleaned)), step=20, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,250))

rarecurve(t(otu_table(MUST_Bacteria_RIS3_2020.2021.Cleaned)), step=20, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,350))


VINE_ITS_All_2020.2021.

VINE_16S_All_2020.2021.

View(data.frame(sample_data(VINE_ITS_All_2020.2021.)))



VINE_ITS_All_2020.2021.RARE <- subset_samples(VINE_ITS_All_2020.2021., !plant_part=="Soil")

VINE_ITS_All_2020.2021.RARE <- prune_taxa(taxa_sums(VINE_ITS_All_2020.2021.RARE)>0,VINE_ITS_All_2020.2021.RARE)

rarecurve(t(otu_table(VINE_ITS_All_2020.2021.RARE)), step=50, cex=0.5, label = F, xlim=c(0,3500), ylim =c(0,50))




VINE_16S_All_2020.2021.RARE <- subset_samples(VINE_16S_All_2020.2021., !plant_part=="Soil")

VINE_16S_All_2020.2021.RARE <- prune_taxa(taxa_sums(VINE_16S_All_2020.2021.RARE)>0,VINE_16S_All_2020.2021.RARE)

VINE_16S_All_2020.2021.RARE <- prune_taxa(taxa_sums(VINE_16S_All_2020.2021.RARE)>0,VINE_16S_All_2020.2021.RARE)

rarecurve(t(otu_table(VINE_16S_All_2020.2021.RARE)), step=50, cex=0.5, label = F, xlim=c(0,3500), ylim =c(0,232))



