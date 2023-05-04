##Roditis
MUST_Bacteria_Roditis_2020.2021_Merged <- merge_samples(MUST_Bacteria_Roditis_2020.2021, "terroir_vinification")

write.table(data.frame(sample_data(MUST_Bacteria_Roditis_2020.2021_Merged)), file="MUST_Bacteria_Roditis_2020.2021_Merged.txt", quote = F,col.names = NA, sep="\t")

SampleDataNew67 <- read.table("MUST_Bacteria_Roditis_2020.2021_Merged.txt", header=T,sep = "\t",row.names = 1)

sample_data(MUST_Bacteria_Roditis_2020.2021_Merged) <- SampleDataNew67

MUST_Bacteria_Roditis_2020.2021_Merged

View(data.frame(sample_data(MUST_Bacteria_Roditis_2020.2021_Merged)))

MUST_Bacteria_Roditis_2020.2021_Merged

saveRDS(MUST_Bacteria_Roditis_2020.2021_Merged, file = "MUST_Bacteria_Roditis_2020.2021_Merged.RDS")

OBJECT READY 

##SIDERITIS
MUST_Bacteria_Sideritis_2020.2021_Merged <- merge_samples(MUST_Bacteria_Sideritis_2020.2021, "terroir_vinification")

write.table(data.frame(sample_data(MUST_Bacteria_Sideritis_2020.2021_Merged)), file="MUST_Bacteria_Sideritis_2020.2021_Merged.txt", quote = F,col.names = NA, sep="\t")

SampleDataNew67 <- read.table("MUST_Bacteria_Sideritis_2020.2021_Merged.txt", header=T,sep = "\t",row.names = 1)

sample_data(MUST_Bacteria_Sideritis_2020.2021_Merged) <- SampleDataNew67

MUST_Bacteria_Sideritis_2020.2021_Merged

View(data.frame(sample_data(MUST_Bacteria_Sideritis_2020.2021_Merged)))

MUST_Bacteria_Sideritis_2020.2021_Merged

saveRDS(MUST_Bacteria_Sideritis_2020.2021_Merged, file = "MUST_Bacteria_Sideritis_2020.2021_Merged.RDS")
.............................
#RODITIS Anticancer#
MUST_Bacteria_Roditis_2020.2021_Merged

MUST_Bacteria_Roditis_2020.2021_Merged_100  <- transform_sample_counts(MUST_Bacteria_Roditis_2020.2021_Merged, function(OTU) 100*OTU/sum(OTU))

MUST_Bacteria_Roditis_2020.2021_Merged_100

ord.nmds.bray1000 <- ordinate(MUST_Bacteria_Roditis_2020.2021_Merged_100, method="NMDS", distance="bray")

plot_ordination(MUST_Bacteria_Roditis_2020.2021_Merged_100, ord.nmds.bray1000, color="terroir", shape ="year", label = "mynms", title=paste("Roditis 2020/2021 (stress ",round(ord.nmds.bray1000$stress, 2),")", sep = "")) + geom_point(size = 3) + scale_color_manual(values=c("#984EA3","#FF7F00"))

AnticancerRoditis100 <- read.table("AnticancerRoditis100.txt", header=T,sep = "\t",row.names = 1)

fitRoditis <- envfit(ord.nmds.bray1000, AnticancerRoditis100[,])

# prepare the names for the to be plotted taxa and save them in a new column
mytax_tbl <- data.frame(tax_table(MUST_Bacteria_Roditis_2020.2021_Merged_100))
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
my_sel_var <- factor(MUST_Bacteria_Roditis_2020.2021_Merged_100@sam_data$terroir)
# convert it also into numbers in orde to use it for colours etc
myterr_sel <- as.numeric(my_sel_var)
# get the arrow data that came out of the fitting of the environmental variables
arrowdata <- data.frame(fitRoditis$vectors$arrows)

# start the graphics device
cairo_pdf("Bacteria Roditis Anticancer.pdf", height = 7, width = 7)

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
title(sub = "Bacteria Roditis Anticancer")
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
arrows(0,0,mynmdsspe[c("ASV01884","ASV01953","ASV01039","ASV00415","ASV00099","ASV00071","ASV00397","ASV00271","ASV00172","ASV02091","ASV00528","ASV00417","ASV01357","ASV00112","ASV00759","ASV00208","ASV00048","ASV00009","ASV00039","ASV00440","ASV00049","ASV00055"),1] , mynmdsspe[c("ASV01884","ASV01953","ASV01039","ASV00415","ASV00099","ASV00071","ASV00397","ASV00271","ASV00172","ASV02091","ASV00528","ASV00417","ASV01357","ASV00112","ASV00759","ASV00208","ASV00048","ASV00009","ASV00039","ASV00440","ASV00049","ASV00055"),2], angle = 25, length = 0.15, col = rgb(40,40,40, max = 255, alpha = 100))

("ASV01884","ASV01953","ASV01039","ASV00415","ASV00099","ASV00071","ASV00397","ASV00271","ASV00172","ASV02091","ASV00528","ASV00417","ASV01357","ASV00112","ASV00759","ASV00208","ASV00048","ASV00009","ASV00039","ASV00440","ASV00049","ASV00055")

("Bacteroidales_sp.***","Flavobacterium_sp.**","Clostridium_s.str._1_sp.**","Asaia_sp.***","Kozakia_sp.***","Enterobacterales_sp.***","Comamonadaceae_sp.**","Sphingomonadaceae_sp.**","Acinetobacter_sp.*","Rhodobacteraceae_sp.*","Sphingobium_sp.*","Micrococcaceae_sp.*","Skermanella_sp.**","Orbaceae_sp.***","Gammaproteobacteria_sp.***","Frateuria_sp.***","Lactobacillus_sp.**","Oenococcus_sp.**","Tatumella_sp.***","Acetobacteraceae_sp.***","Komagataeibacter_sp.***","Gluconobacter_sp.***")


ASV01884 Bacteroidales_sp.***
  ASV01953 Flavobacterium_sp.**
  ASV01039 Clostridium_s.str._1_sp.**
  ASV00415 Asaia_sp.***
  ASV00099 Kozakia_sp.***
  ASV00071 Enterobacterales_sp.***
  ASV00397 Comamonadaceae_sp.**
  ASV00271 Sphingomonadaceae_sp.**
  ASV00172 Acinetobacter_sp.*
  ASV02091 Rhodobacteraceae_sp.*
  ASV00528 Sphingobium_sp.*
  ASV00417 Micrococcaceae_sp.*
  ASV01357 Skermanella_sp.**
  ASV00112 Orbaceae_sp.***
  ASV00759 Gammaproteobacteria_sp.***
  ASV00208 Frateuria_sp.***
  ASV00048 Lactobacillus_sp.**
  ASV00009 Oenococcus_sp.**
  ASV00039 Tatumella_sp.***
  ASV00440 Acetobacteraceae_sp.***
  ASV00049 Komagataeibacter_sp.***
  ASV00055 Gluconobacter_sp.***
  
  
  ##LABELS Short-cut##
  
  a <- c("Bacteroidales_sp.***","Flavobacterium_sp.**","Clostridium_s.str._1_sp.**","Asaia_sp.***","Kozakia_sp.***","Enterobacterales_sp.***","Comamonadaceae_sp.**","Sphingomonadaceae_sp.**","Acinetobacter_sp.*","Rhodobacteraceae_sp.*","Sphingobium_sp.*","Micrococcaceae_sp.*","Skermanella_sp.**","Orbaceae_sp.***","Gammaproteobacteria_sp.***","Frateuria_sp.***","Lactobacillus_sp.**","Oenococcus_sp.**","Tatumella_sp.***","Acetobacteraceae_sp.***","Komagataeibacter_sp.***","Gluconobacter_sp.***")


install.packages("plotrix")

plotrix::thigmophobe.labels(1.2*mynmdsspe[c("ASV01884","ASV01953","ASV01039","ASV00415","ASV00099","ASV00071","ASV00397","ASV00271","ASV00172","ASV02091","ASV00528","ASV00417","ASV01357","ASV00112","ASV00759","ASV00208","ASV00048","ASV00009","ASV00039","ASV00440","ASV00049","ASV00055"),1], 1.2*mynmdsspe[c("ASV01884","ASV01953","ASV01039","ASV00415","ASV00099","ASV00071","ASV00397","ASV00271","ASV00172","ASV02091","ASV00528","ASV00417","ASV01357","ASV00112","ASV00759","ASV00208","ASV00048","ASV00009","ASV00039","ASV00440","ASV00049","ASV00055"),2], labels = a, cex = .6, font = 2, col = rgb(120,120,120,max = 255, alpha =200)) 

#simantiko# plotrix::thigmophobe.labels(1.2*mynmdsspe[1:15,1], 1.2*mynmdsspe[1:15,2], labels = mytax_tbl[row.names(mynmdsspe)[1:15],"forplt"], cex = .6, font = 2, col = rgb(153,153,153, max = 255, alpha = 175)) # the color is equivalent to "grey60", but transparent
# the following prints the legend
graphics::legend("topright",bty = "n", legend = levels(my_sel_var), pch = 21, pt.bg = myplotcols[1:length(levels(my_sel_var))], pt.cex = 1.5)

dev.off()

...............................................................
#SIDERITIS Anticancer#
MUST_Bacteria_Sideritis_2020.2021_Merged

MUST_Bacteria_Sideritis_2020.2021_Merged_100  <- transform_sample_counts(MUST_Bacteria_Sideritis_2020.2021_Merged, function(OTU) 100*OTU/sum(OTU))

MUST_Bacteria_Sideritis_2020.2021_Merged_100

ord.nmds.bray1000 <- ordinate(MUST_Bacteria_Sideritis_2020.2021_Merged_100, method="RDA", distance="bray")

plot_ordination(MUST_Bacteria_Sideritis_2020.2021_Merged_100, ord.nmds.bray1000, color="terroir", shape ="year", label = "mynms", title=paste("Sideritis 2020/2021 ")) + geom_point(size = 3) + scale_color_manual(values=c("#984EA3","#FF7F00"))

AnticancerSideritis100 <- read.table("AnticancerSideritis100.txt", header=T,sep = "\t",row.names = 1)

fitSideritis <- envfit(ord.nmds.bray1000, AnticancerSideritis100[,])

# prepare the names for the to be plotted taxa and save them in a new column
mytax_tbl <- data.frame(tax_table(MUST_Bacteria_Sideritis_2020.2021_Merged_100))
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
mynmdssit <- scores(ord.nmds.bray1000, display = "site")

# prep the species points
mynmdsspe <- scores(ord.nmds.bray1000, display = "species")

# prep the variable of interest (e.g. terroir) has to be a factor
my_sel_var <- factor(MUST_Bacteria_Sideritis_2020.2021_Merged_100@sam_data$terroir)
# convert it also into numbers in orde to use it for colours etc
myterr_sel <- as.numeric(my_sel_var)
# get the arrow data that came out of the fitting of the environmental variables
arrowdata <- data.frame(fitSideritis$vectors$arrows)

# start the graphics device
cairo_pdf("Bacteria Sideritis Anticancer.pdf", height = 7, width = 7)

# draw and empty plot that you will start to populate with points, arrows, ellipses, names etc.
plot(mynmdssit, frame = F, cex = 0, pch = 21, xlim = c(min(1.5*mynmdssit[,1]),max(1.5*mynmdssit[,1])))
# first add the ellipses in order tto keep them in the background and prevent them to obstruct information
vegan::ordiellipse(mynmdssit, groups = my_sel_var, kind = "ehull", lty = 2, lwd=1)
# add the sample points and give them colors one for each treatment
points(mynmdssit, bg = myplotcols[myterr_sel], pch = 21, cex = 1.5
##gia keimeno sta simeia##
, text(mynmdssit, labels = row.names(mynmdssit), font = 6, col = rgb(55,55,55, max = 255, alpha = 100)))

# write the stress value in the bottom left of the plot (you need to change the global "adj" parameter from 0.5 to 0 in order to add the text in the left instead of the middle (if you gave the value of 1 it would add the text in the rightmost side... I provide some text as example))
par(adj = 0)
title(sub = paste("stress ", round(ord.nmds.bray1000$stress,2), sep = ""), cex.sub = 1.2)

par(adj = 1)
title(sub = "Bacteria Sideritis Anticancer")
par(adj = .5)
# add the env parameter arrows (in the rgb colouring mode we have the red, green and blue values from 0 to 255 and also the alpha value or transparency which also ranges between 0 and 255)

arrows(0,0,2.5*arrowdata[,1] , 2.5*arrowdata[,2], angle = 25, length = 0.15, col = rgb(20,20,20, max = 255, alpha = 100), lwd = 3)
# also the labeling text
text(2.5*arrowdata[,1], 2.5*arrowdata[,2], labels = row.names(arrowdata), cex = 1.3, font = 2, col = rgb(20,20,20, max = 255, alpha = 255)) 

##simantiko species arrows and labels##
-----------------------------------------------------------------
  ##Epilego ta ASVs pou thelo ite aritmitika ite onomastika
  
  ##Aritmitika##
  arrows(0,0,mynmdsspe[1:22,1] , mynmdsspe[1:22,2], angle = 25, length = 0.15, col = rgb(40,40,40, max = 255, alpha = 100))


plotrix::thigmophobe.labels(1.2*mynmdsspe[1:20,1], 1.2*mynmdsspe[1:20,2], labels = mytax_tbl[row.names(mynmdsspe)[1:20],"forplt"], cex = .6, font = 2, col = rgb(120,120,120, max = 255, alpha =200))


##Onomastika anti gia diaforika afthona##
arrows(0,0,25*mynmdsspe[c("ASV00144","ASV00049","ASV00450","ASV00329","ASV00222","ASV00245","ASV00717","ASV00148","ASV00133","ASV00299","ASV00106","ASV00101","ASV00549","ASV00544","ASV00376","ASV00313","ASV00664","ASV00493","ASV00441","ASV00741","ASV00214","ASV01629"),1] , 25*mynmdsspe[c("ASV00144","ASV00049","ASV00450","ASV00329","ASV00222","ASV00245","ASV00717","ASV00148","ASV00133","ASV00299","ASV00106","ASV00101","ASV00549","ASV00544","ASV00376","ASV00313","ASV00664","ASV00493","ASV00441","ASV00741","ASV00214","ASV01629"),2], angle = 25, length = 0.20, col = rgb(40,40,40, max = 255, alpha = 100))


("ASV00144","ASV00049","ASV00450","ASV00329","ASV00222","ASV00245","ASV00717","ASV00148","ASV00133","ASV00299","ASV00106","ASV00101","ASV00549","ASV00544","ASV00376","ASV00313","ASV00664","ASV00493","ASV00441","ASV00741","ASV00214","ASV01629")

("Sphingomonas_sp.***","Komagataeibacter_sp.*","Methylobacterium_sp.***","Sphingomonadaceae_sp.***","Microbacteriaceae_sp.***","Planococcaceae_sp.***","Anaerocolumna_sp.***","Lactobacillus_sp.***","Bacillales_sp.***","Bacillaceae_sp.***","Acinetobacter_sp.***","Paenibacillus_sp.***","Lactococcus_sp.**","Clostridium_s.str._3_sp.***","Streptomycetaceae_sp.**","Streptomyces_sp.**","Lysinibacillus_sp.*","Clostridium_s.str._1_sp.**","Stenotrophomonas_sp.**","Burkholderiales_sp.**","Burkholderia_sp.**","Acetobacteraceae_sp.**")

##LABELS Short-cut##
ASV00144 Sphingomonas_sp.***
  ASV00049 Komagataeibacter_sp.*
  ASV00450 Methylobacterium_sp.***
  ASV00329 Sphingomonadaceae_sp.***
  ASV00222 Microbacteriaceae_sp.***
  ASV00245 Planococcaceae_sp.***
  ASV00717 Anaerocolumna_sp.***
  ASV00148 Lactobacillus_sp.***
  ASV00133 Bacillales_sp.***
  ASV00299 Bacillaceae_sp.***
  ASV00106 Acinetobacter_sp.***
  ASV00101 Paenibacillus_sp.***
  ASV00549 Lactococcus_sp.**
  ASV00544 Clostridium_s.str._3_sp.***
  ASV00376 Streptomycetaceae_sp.**
  ASV00313 Streptomyces_sp.**
  ASV00664 Lysinibacillus_sp.*
  ASV00493 Clostridium_s.str._1_sp.**
  ASV00441 Stenotrophomonas_sp.**
  ASV00741 Burkholderiales_sp.**
  ASV00214 Burkholderia_sp.**
  ASV01629 Acetobacteraceae_sp.**##
  
  
a <- c("Sphingomonas_sp.***","Komagataeibacter_sp.*","Methylobacterium_sp.***","Sphingomonadaceae_sp.***","Microbacteriaceae_sp.***","Planococcaceae_sp.***","Anaerocolumna_sp.***","Lactobacillus_sp.***","Bacillales_sp.***","Bacillaceae_sp.***","Acinetobacter_sp.***","Paenibacillus_sp.***","Lactococcus_sp.**","Clostridium_s.str._3_sp.***","Streptomycetaceae_sp.**","Streptomyces_sp.**","Lysinibacillus_sp.*","Clostridium_s.str._1_sp.**","Stenotrophomonas_sp.**","Burkholderiales_sp.**","Burkholderia_sp.**","Acetobacteraceae_sp.**")


install.packages("plotrix")

plotrix::thigmophobe.labels(25*mynmdsspe[c("ASV00144","ASV00049","ASV00450","ASV00329","ASV00222","ASV00245","ASV00717","ASV00148","ASV00133","ASV00299","ASV00106","ASV00101","ASV00549","ASV00544","ASV00376","ASV00313","ASV00664","ASV00493","ASV00441","ASV00741","ASV00214","ASV01629"),1], 25*mynmdsspe[c("ASV00144","ASV00049","ASV00450","ASV00329","ASV00222","ASV00245","ASV00717","ASV00148","ASV00133","ASV00299","ASV00106","ASV00101","ASV00549","ASV00544","ASV00376","ASV00313","ASV00664","ASV00493","ASV00441","ASV00741","ASV00214","ASV01629"),2], labels = a, cex = .6, font = 2, col = rgb(120,120,120,max = 255, alpha =200)) 

#simantiko# plotrix::thigmophobe.labels(1.2*mynmdsspe[1:15,1], 1.2*mynmdsspe[1:15,2], labels = mytax_tbl[row.names(mynmdsspe)[1:15],"forplt"], cex = .6, font = 2, col = rgb(153,153,153, max = 255, alpha = 175)) # the color is equivalent to "grey60", but transparent
# the following prints the legend
graphics::legend("topright",bty = "n", legend = levels(my_sel_var), pch = 21, pt.bg = myplotcols[1:length(levels(my_sel_var))], pt.cex = 1.5)

dev.off()