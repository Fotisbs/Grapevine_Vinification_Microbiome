##Roditis
MUST_Fungi_Roditis_2020.2021_Merged <- merge_samples(MUST_Fungi_Roditis_2020.2021, "terroir_vinification")

write.table(data.frame(sample_data(MUST_Fungi_Roditis_2020.2021_Merged)), file="MUST_Fungi_Roditis_2020.2021_Merged.txt", quote = F,col.names = NA, sep="\t")

SampleDataNew67 <- read.table("MUST_Fungi_Roditis_2020.2021_Merged.txt", header=T,sep = "\t",row.names = 1)

sample_data(MUST_Fungi_Roditis_2020.2021_Merged) <- SampleDataNew67

MUST_Fungi_Roditis_2020.2021_Merged

View(data.frame(sample_data(MUST_Fungi_Roditis_2020.2021_Merged)))

MUST_Fungi_Roditis_2020.2021_Merged

saveRDS(MUST_Fungi_Roditis_2020.2021_Merged, file = "MUST_Fungi_Roditis_2020.2021_Merged.RDS")

OBJECT READY 

##SIDERITIS
MUST_Fungi_Sideritis_2020.2021_Merged <- merge_samples(MUST_Fungi_Sideritis_2020.2021, "terroir_vinification")

write.table(data.frame(sample_data(MUST_Fungi_Sideritis_2020.2021_Merged)), file="MUST_Fungi_Sideritis_2020.2021_Merged.txt", quote = F,col.names = NA, sep="\t")

SampleDataNew67 <- read.table("MUST_Fungi_Sideritis_2020.2021_Merged.txt", header=T,sep = "\t",row.names = 1)

sample_data(MUST_Fungi_Sideritis_2020.2021_Merged) <- SampleDataNew67

MUST_Fungi_Sideritis_2020.2021_Merged

View(data.frame(sample_data(MUST_Fungi_Sideritis_2020.2021_Merged)))

MUST_Fungi_Sideritis_2020.2021_Merged

saveRDS(MUST_Fungi_Sideritis_2020.2021_Merged, file = "MUST_Fungi_Sideritis_2020.2021_Merged.RDS")
.............................
#RODITIS Anticancer#
MUST_Fungi_Roditis_2020.2021_Merged

MUST_Fungi_Roditis_2020.2021_Merged_100  <- transform_sample_counts(MUST_Fungi_Roditis_2020.2021_Merged, function(OTU) 100*OTU/sum(OTU))

MUST_Fungi_Roditis_2020.2021_Merged_100

ord.nmds.bray1000 <- ordinate(MUST_Fungi_Roditis_2020.2021_Merged_100, method="NMDS", distance="bray")

plot_ordination(MUST_Fungi_Roditis_2020.2021_Merged_100, ord.nmds.bray1000, color="terroir", shape ="year", label = "mynms", title=paste("Roditis 2020/2021 (stress ",round(ord.nmds.bray1000$stress, 2),")", sep = "")) + geom_point(size = 3) + scale_color_manual(values=c("#984EA3","#FF7F00"))

AnticancerRoditis100 <- read.table("AnticancerRoditis100.txt", header=T,sep = "\t",row.names = 1)

fitRoditis <- envfit(ord.nmds.bray1000, AnticancerRoditis100[,])

# prepare the names for the to be plotted taxa and save them in a new column
mytax_tbl <- data.frame(tax_table(MUST_Fungi_Roditis_2020.2021_Merged_100))
# the following command pastes the Phylum column with the Genus one
# !!! make sure to get rid of the NAs with the for loop as we discussed before !!!

# For ITS - Remove letter from taxonomy

mytax_tbl$forplt <- for (i in c(1:nrow(mytax_tbl))) {
  for(j in c(1:ncol(mytax_tbl))) {
    mytax_tbl[i,j] <- gsub("[a-z]__","",mytax_tbl[i,j])
  }
}


# prepare the plotting colours
myplotcols <- RColorBrewer::brewer.pal(n = 4, name = 'RdBu')
# prep the plot points
mynmdssit <- ord.nmds.bray1000$points

# prep the species points
mynmdsspe <- ord.nmds.bray1000$species

# prep the variable of interest (e.g. terroir) has to be a factor
my_sel_var <- factor(MUST_Fungi_Roditis_2020.2021_Merged_100@sam_data$terroir)
# convert it also into numbers in orde to use it for colours etc
myterr_sel <- as.numeric(my_sel_var)
# get the arrow data that came out of the fitting of the environmental variables
arrowdata <- data.frame(fitRoditis$vectors$arrows)

# start the graphics device
cairo_pdf("Fungi Roditis Anticancer.pdf", height = 7, width = 7)

# draw and empty plot that you will start to populate with points, arrows, ellipses, names etc.
plot(mynmdssit, frame = F, cex = 0, pch = 21, xlim = c(min(1.3*mynmdssit[,1]),max(1.3*mynmdssit[,1])))
# first add the ellipses in order tto keep them in the background and prevent them to obstruct information
vegan::ordiellipse(mynmdssit, groups = my_sel_var, kind = "ehull", lty = 2, lwd=1)
# add the sample points and give them colors one for each treatment
points(mynmdssit, bg = myplotcols[myterr_sel], pch = 21, cex = 1.5)


##gia keimeno sta simeia##
, text(mynmdssit, labels = row.names(mynmdssit), font = 6, col = rgb(55,55,55, max = 255, alpha = 100)))

# write the stress value in the bottom left of the plot (you need to change the global "adj" parameter from 0.5 to 0 in order to add the text in the left instead of the middle (if you gave the value of 1 it would add the text in the rightmost side... I provide some text as example))
par(adj = 0)
title(sub = paste("stress ", round(ord.nmds.bray1000$stress,2), sep = ""), cex.sub = 1.2)

par(adj = 1)
title(sub = "Fungi Roditis Anticancer")
par(adj = .5)
# add the env parameter arrows (in the rgb colouring mode we have the red, green and blue values from 0 to 255 and also the alpha value or transparency which also ranges between 0 and 255)

arrows(0,0,0.3*arrowdata[,1] , 0.3*arrowdata[,2], angle = 25, length = 0.15, col = rgb(20,20,20, max = 255, alpha = 100), lwd = 3)
# also the labeling text
text(0.4*arrowdata[,1], 0.4*arrowdata[,2], labels = row.names(arrowdata), cex = 1.3, font = 2, col = rgb(20,20,20, max = 255, alpha = 255)) 

##simantiko species arrows and labels##
-----------------------------------------------------------------
  ##Epilego ta ASVs pou thelo ite aritmitika ite onomastika
  
  ##Aritmitika##
  arrows(0,0,mynmdsspe[1:22,1] , mynmdsspe[1:22,2], angle = 25, length = 0.15, col = rgb(40,40,40, max = 255, alpha = 100))


plotrix::thigmophobe.labels(1.2*mynmdsspe[1:20,1], 1.2*mynmdsspe[1:20,2], labels = mytax_tbl[row.names(mynmdsspe)[1:20],"forplt"], cex = .6, font = 2, col = rgb(120,120,120, max = 255, alpha =200))

##Onomastika anti gia diaforika afthona##
arrows(0,0,mynmdsspe[c("ASV0001","ASV0283","ASV0030","ASV0080","ASV0065","ASV0045","ASV0012","ASV0048","ASV0081","ASV0153","ASV0085","ASV0014","ASV0015","ASV0063","ASV0002","ASV0059","ASV0016","ASV0018","ASV0067","ASV0192","ASV0337","ASV0032"),1] , mynmdsspe[c("ASV0001","ASV0283","ASV0030","ASV0080","ASV0065","ASV0045","ASV0012","ASV0048","ASV0081","ASV0153","ASV0085","ASV0014","ASV0015","ASV0063","ASV0002","ASV0059","ASV0016","ASV0018","ASV0067","ASV0192","ASV0337","ASV0032"),2], angle = 25, length = 0.15, col = rgb(40,40,40, max = 255, alpha = 100))

##LABELS Short-cut##

a <- c("Saccharomyces_sp.***","Didymellaceae_sp.**","Cladosporium_sp.*","Peniophora_sp.*","Peniophora_sp.***","Rhodotorula_nothofagi***","Torulaspora_delbrueckii***","Torulaspora_delbrueckii**","Penicillium_sp.*","Lambertella_sp.*","Papiliotrema_terrestris*","Aspergillus_sp.*","Vishniacozyma_carnescens*","Hanseniaspora_sp.*","Saccharomyces_sp.***","Udeniomyces_puniceus***","Lachancea_quebecensis**","Lachancea_quebecensis*","Quambalaria_cyanescens***","Peniophora_sp.*","Lachancea_fermentati***","Microbotryomycetes_sp.***") 


install.packages("plotrix")

plotrix::thigmophobe.labels(1.2*mynmdsspe[c("ASV0001","ASV0283","ASV0030","ASV0080","ASV0065","ASV0045","ASV0012","ASV0048","ASV0081","ASV0153","ASV0085","ASV0014","ASV0015","ASV0063","ASV0002","ASV0059","ASV0016","ASV0018","ASV0067","ASV0192","ASV0337","ASV0032"),1], 1.2*mynmdsspe[c("ASV0001","ASV0283","ASV0030","ASV0080","ASV0065","ASV0045","ASV0012","ASV0048","ASV0081","ASV0153","ASV0085","ASV0014","ASV0015","ASV0063","ASV0002","ASV0059","ASV0016","ASV0018","ASV0067","ASV0192","ASV0337","ASV0032"),2], labels = a, cex = .6, font = 2, col = rgb(120,120,120,max = 255, alpha =200)) 

#simantiko# plotrix::thigmophobe.labels(1.2*mynmdsspe[1:15,1], 1.2*mynmdsspe[1:15,2], labels = mytax_tbl[row.names(mynmdsspe)[1:15],"forplt"], cex = .6, font = 2, col = rgb(153,153,153, max = 255, alpha = 175)) # the color is equivalent to "grey60", but transparent
# the following prints the legend
graphics::legend("topright",bty = "n", legend = levels(my_sel_var), pch = 21, pt.bg = myplotcols[1:length(levels(my_sel_var))], pt.cex = 1.5)

dev.off()

...............................................................
#SIDERITIS Anticancer#
MUST_Fungi_Sideritis_2020.2021_Merged

MUST_Fungi_Sideritis_2020.2021_Merged_100  <- transform_sample_counts(MUST_Fungi_Sideritis_2020.2021_Merged, function(OTU) 100*OTU/sum(OTU))

MUST_Fungi_Sideritis_2020.2021_Merged_100

ord.nmds.bray1000 <- ordinate(MUST_Fungi_Sideritis_2020.2021_Merged_100, method="NMDS", distance="bray")

plot_ordination(MUST_Fungi_Sideritis_2020.2021_Merged_100, ord.nmds.bray1000, color="terroir", shape ="year", label = "mynms", title=paste("Sideritis 2020/2021 (stress ",round(ord.nmds.bray1000$stress, 2),")", sep = "")) + geom_point(size = 3) + scale_color_manual(values=c("#984EA3","#FF7F00"))

AnticancerSideritis100 <- read.table("AnticancerSideritis100.txt", header=T,sep = "\t",row.names = 1)

fitSideritis <- envfit(ord.nmds.bray1000, AnticancerSideritis100[,])

# prepare the names for the to be plotted taxa and save them in a new column
mytax_tbl <- data.frame(tax_table(MUST_Fungi_Sideritis_2020.2021_Merged_100))
# the following command pastes the Phylum column with the Genus one
# !!! make sure to get rid of the NAs with the for loop as we discussed before !!!

# For ITS - Remove letter from taxonomy

mytax_tbl$forplt <- for (i in c(1:nrow(mytax_tbl))) {
  for(j in c(1:ncol(mytax_tbl))) {
    mytax_tbl[i,j] <- gsub("[a-z]__","",mytax_tbl[i,j])
  }
}


# prepare the plotting colours
myplotcols <- RColorBrewer::brewer.pal(n = 4, name = 'RdBu')
# prep the plot points
mynmdssit <- ord.nmds.bray1000$points

# prep the species points
mynmdsspe <- ord.nmds.bray1000$species

# prep the variable of interest (e.g. terroir) has to be a factor
my_sel_var <- factor(MUST_Fungi_Sideritis_2020.2021_Merged_100@sam_data$terroir)
# convert it also into numbers in orde to use it for colours etc
myterr_sel <- as.numeric(my_sel_var)
# get the arrow data that came out of the fitting of the environmental variables
arrowdata <- data.frame(fitSideritis$vectors$arrows)

# start the graphics device
cairo_pdf("Fungi Sideritis Anticancer.pdf", height = 7, width = 7)

# draw and empty plot that you will start to populate with points, arrows, ellipses, names etc.
plot(mynmdssit, frame = F, cex = 0, pch = 21, xlim = c(min(1.3*mynmdssit[,1]),max(1.3*mynmdssit[,1])))
# first add the ellipses in order tto keep them in the background and prevent them to obstruct information
vegan::ordiellipse(mynmdssit, groups = my_sel_var, kind = "ehull", lty = 2, lwd=1)
# add the sample points and give them colors one for each treatment
points(mynmdssit, bg = myplotcols[myterr_sel], pch = 21, cex = 1.5)


##gia keimeno sta simeia##
, text(mynmdssit, labels = row.names(mynmdssit), font = 6, col = rgb(55,55,55, max = 255, alpha = 100)))

# write the stress value in the bottom left of the plot (you need to change the global "adj" parameter from 0.5 to 0 in order to add the text in the left instead of the middle (if you gave the value of 1 it would add the text in the rightmost side... I provide some text as example))
par(adj = 0)
title(sub = paste("stress ", round(ord.nmds.bray1000$stress,2), sep = ""), cex.sub = 1.2)

par(adj = 1)
title(sub = "Fungi Sideritis Anticancer")
par(adj = .5)
# add the env parameter arrows (in the rgb colouring mode we have the red, green and blue values from 0 to 255 and also the alpha value or transparency which also ranges between 0 and 255)

arrows(0,0,0.3*arrowdata[,1] , 0.3*arrowdata[,2], angle = 25, length = 0.15, col = rgb(20,20,20, max = 255, alpha = 100), lwd = 3)
# also the labeling text
text(0.4*arrowdata[,1], 0.4*arrowdata[,2], labels = row.names(arrowdata), cex = 1.3, font = 2, col = rgb(20,20,20, max = 255, alpha = 255)) 

##simantiko species arrows and labels##
-----------------------------------------------------------------
  ##Epilego ta ASVs pou thelo ite aritmitika ite onomastika
  
  ##Aritmitika##
  arrows(0,0,mynmdsspe[1:22,1] , mynmdsspe[1:22,2], angle = 25, length = 0.15, col = rgb(40,40,40, max = 255, alpha = 100))


plotrix::thigmophobe.labels(1.2*mynmdsspe[1:20,1], 1.2*mynmdsspe[1:20,2], labels = mytax_tbl[row.names(mynmdsspe)[1:20],"forplt"], cex = .6, font = 2, col = rgb(120,120,120, max = 255, alpha =200))

##Onomastika anti gia diaforika afthona##
arrows(0,0,mynmdsspe[c("ASV0001","ASV0002","ASV0005","ASV0006","ASV0011","ASV0012","ASV0014","ASV0022","ASV0028","ASV0029","ASV0035","ASV0041","ASV0091","ASV0100","ASV0110","ASV0134","ASV0137","ASV0156","ASV0167","ASV0170","ASV0178","ASV0397"),1] , mynmdsspe[c("ASV0001","ASV0002","ASV0005","ASV0006","ASV0011","ASV0012","ASV0014","ASV0022","ASV0028","ASV0029","ASV0035","ASV0041","ASV0091","ASV0100","ASV0110","ASV0134","ASV0137","ASV0156","ASV0167","ASV0170","ASV0178","ASV0397"),2], angle = 25, length = 0.15, col = rgb(40,40,40, max = 255, alpha = 100))

##LABELS Short-cut##
ASV0001_Saccharomyces_sp.***,
ASV0002_Saccharomyces_sp.***,
ASV0005_Lachancea_quebecensis**,
ASV0006_Sclerotiniaceae_sp.**,
ASV0011_Aspergillus_awamori**,
ASV0012_Torulaspora_delbrueckii**,
ASV0014_Aspergillus_sp.***,
ASV0022_Botryosphaeria_sp.**,
ASV0028_Aspergillus_awamori***,
ASV0029_Talaromyces_minioluteus**,
ASV0035_Aspergillus_sp.**,
ASV0041_Sordariomycetes_sp.**,
ASV0091_Talaromyces_minioluteus**,
ASV0100_Phaeoacremonium_iranianum***,
ASV0110_Cladosporium_sp.*,
ASV0134_Zygosaccharomyces_bisporus***,
ASV0137_Clathrus_ruber***,
ASV0156_Penicillium_georgiense***,
ASV0167_Clathraceae_sp.***,
ASV0170_Ascomycota_sp.***,
ASV0178_Penicillium_sp.***,
ASV0397_Saccharomycetaceae_sp.**
  
a <- c("Saccharomyces_sp.***","Saccharomyces_sp.***","Lachancea_quebecensis**","Sclerotiniaceae_sp.**","Aspergillus_awamori**","Torulaspora_delbrueckii**","Aspergillus_sp.***","Botryosphaeria_sp.**","Aspergillus_awamori***","Talaromyces_minioluteus**","Aspergillus_sp.**","Sordariomycetes_sp.**","Talaromyces_minioluteus**","Phaeoacremonium_iranianum***","Cladosporium_sp.*","Zygosaccharomyces_bisporus***","Clathrus_ruber***","Penicillium_georgiense***","Clathraceae_sp.***","Ascomycota_sp.***","Penicillium_sp.***","Saccharomycetaceae_sp.**") 


install.packages("plotrix")

plotrix::thigmophobe.labels(1.2*mynmdsspe[c("ASV0001","ASV0002","ASV0005","ASV0006","ASV0011","ASV0012","ASV0014","ASV0022","ASV0028","ASV0029","ASV0035","ASV0041","ASV0091","ASV0100","ASV0110","ASV0134","ASV0137","ASV0156","ASV0167","ASV0170","ASV0178","ASV0397"),1], 1.2*mynmdsspe[c("ASV0001","ASV0002","ASV0005","ASV0006","ASV0011","ASV0012","ASV0014","ASV0022","ASV0028","ASV0029","ASV0035","ASV0041","ASV0091","ASV0100","ASV0110","ASV0134","ASV0137","ASV0156","ASV0167","ASV0170","ASV0178","ASV0397"),2], labels = a, cex = .6, font = 2, col = rgb(120,120,120,max = 255, alpha =200)) 

#simantiko# plotrix::thigmophobe.labels(1.2*mynmdsspe[1:15,1], 1.2*mynmdsspe[1:15,2], labels = mytax_tbl[row.names(mynmdsspe)[1:15],"forplt"], cex = .6, font = 2, col = rgb(153,153,153, max = 255, alpha = 175)) # the color is equivalent to "grey60", but transparent
# the following prints the legend
graphics::legend("topright",bty = "n", legend = levels(my_sel_var), pch = 21, pt.bg = myplotcols[1:length(levels(my_sel_var))], pt.cex = 1.5)

dev.off()
