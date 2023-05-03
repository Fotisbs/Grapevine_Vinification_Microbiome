##Rarefaction Curves analysis######

##load phyloseq object for fungi, (the XXXXXX.RDS File from the construcrion of the phyloseq object raw counts)##

fungi_vinification_Annotated 

rarecurve(t(otu_table(fungi_vinification_Annotated)), step=20, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,250))

rarecurve(t(otu_table(fungi_vinification_Annotated)), step=20, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,350))
