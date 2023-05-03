                                                       ##Rarefaction Curves analysis######

##load phyloseq object for bacteria, (the XXXXXX.RDS File from the construcrion of the phyloseq object raw counts)##

bacteria_vinification_Annotated 

rarecurve(t(otu_table(bacteria_vinification_Annotated)), step=20, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,250))

rarecurve(t(otu_table(bacteria_vinification_Annotated)), step=20, cex=0.5, label = F, xlim=c(0,1500), ylim =c(0,350))
