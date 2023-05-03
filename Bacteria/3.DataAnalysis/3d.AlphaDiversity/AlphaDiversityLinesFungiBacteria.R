##ISOS XREISIMO GIA TO MELLON##
plot_richness(MUST_Fungi_RIS3_2020.2021.C.A, x="stage", measures=c("InvSimpson"), color="year") + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) + stat_summary(fun=mean, geom="line", size=2)

plot_richness(MUST_Bacteria_RIS3_2020.2021.C.A, x="stage", measures=c("InvSimpson"), color="year") + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) + geom_boxplot(alpha=0.6) 


MUST_Fungi_RIS3_2020.2021.C.A
MUST_Bacteria_RIS3_2020.2021.C.A


plot_richness(MUST_Fungi_RIS3_2020.2021.C.A, x="stage", measures=c("Chao1")) + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) 

plot_richness(MUST_Fungi_RIS3_2020.2021.C.A, x="stage", measures=c("Shannon","Chao1","ACE")) + facet_wrap(~terroir_vinification, scales = "free_x") 



mysamdat(sample_names)



MUST_Fungi_RIS3_2020.2021.Cleaned
MUST_Bacteria_RIS3_2020.2021.Cleaned

##Start Extra Figures Alpha Diversity, lines me standar errors bars##
##FUNGI
MUST_Bacteria_RIS3_2020.2021.C.A_nms <- MUST_Bacteria_RIS3_2020.2021.Cleaned
sample_names(MUST_Bacteria_RIS3_2020.2021.C.A_nms) <- paste("samp",sample_names(MUST_Bacteria_RIS3_2020.2021.Cleaned), sep = "")

##c("Observed", "Chao1", "ACE", "Shannon", "Simpson", "InvSimpson", "Fisher").
myrichness <- estimate_richness(MUST_Bacteria_RIS3_2020.2021.C.A_nms, split = TRUE, measures = "ACE") # calculate the Inverse Simpson index
mysamdat <- data.frame(sample_data(MUST_Bacteria_RIS3_2020.2021.C.A_nms)[,c("terroir_vinification","stage","year","variety","terroir","vinification")]) # obtain the sample info data.frame
myrichness_fin <- merge(myrichness, mysamdat, by = "row.names") # merge the two tables
row.names(myrichness_fin) <- myrichness_fin$Row.names # add the row.names after merging
myrichness_fin <- myrichness_fin[,-which(colnames(myrichness_fin)%in%"Row.names")] # remove the remnant row names column
myrichness_fin$year <- as.factor(gsub("VINTAGE_","",myrichness_fin$year))

# prepare the plot
plt <- ggplot(myrichness_fin, aes(stage, ACE, group = year, colour = year)) + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) + ylim(0,800)
plt <- plt + stat_summary(fun = "mean", geom="line", size = 1, position=position_dodge(0))  
plt <- plt + stat_summary(fun.data="mean_se", geom="errorbar", width=0.5) + theme_light()
##END FUNGI#####################




##Start Extra Figures Alpha Diversity, lines me standar errors bars##
##FUNGI ##problem with other indexes Chao1
MUST_Fungi_RIS3_2020.2021.C.A_nms <- MUST_Fungi_RIS3_2020.2021.C.A
sample_names(MUST_Fungi_RIS3_2020.2021.C.A_nms) <- paste("samp",sample_names(MUST_Fungi_RIS3_2020.2021.C.A), sep = "")
myrichness <- estimate_richness(MUST_Fungi_RIS3_2020.2021.C.A_nms, split = TRUE, measures=c("Observed", "InvSimpson", "Shannon", "Chao1")) # calculate the Inverse Simpson index
mysamdat <- data.frame(sample_data(MUST_Fungi_RIS3_2020.2021.C.A_nms)[,c("terroir_vinification","stage","year","variety","terroir")]) # obtain the sample info data.frame
myrichness_fin <- merge(myrichness, mysamdat, by = "row.names") # merge the two tables
row.names(myrichness_fin) <- myrichness_fin$Row.names # add the row.names after merging
myrichness_fin <- myrichness_fin[,-which(colnames(myrichness_fin)%in%"Row.names")] # remove the remnant row names column
myrichness_fin$year <- as.factor(gsub("VINTAGE_","",myrichness_fin$year))

# prepare the plot
plt <- ggplot(myrichness_fin, aes(stage, Chao1, group = year, colour = year)) + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) 
plt <- plt + stat_summary(fun = "mean", geom="line", size = 1, position=position_dodge(0))  
plt <- plt + stat_summary(fun.data="mean_se", geom="errorbar", width=0.5) + theme_light()
##END FUNGI#####################


























##BACTERIA
myrichness <- estimate_richness(MUST_Bacteria_RIS3_2020.2021.C.A, split = TRUE, measures=c("Observed", "InvSimpson", "Shannon", "Chao1")) # calculate the Inverse Simpson index
mysamdat <- data.frame(sample_data(MUST_Bacteria_RIS3_2020.2021.C.A)[,c("terroir_vinification","stage","year","variety","terroir")]) # obtain the sample info data.frame

View(data.frame(myrichness))

myrichness_fin <- merge(myrichness, mysamdat, by = "row.names") # merge the two tables
row.names(myrichness_fin) <- myrichness_fin$Row.names # add the row.names after merging
myrichness_fin <- myrichness_fin[,-which(colnames(myrichness_fin)%in%"Row.names")] # remove the remnant row names column
myrichness_fin$year <- as.factor(gsub("VINTAGE_","",myrichness_fin$year))

# prepare the plot
plt <- ggplot(myrichness_fin, aes(stage, myrichness_fin, group = year, colour = year)) + facet_wrap(~terroir_vinification, scales = "fixed", nrow = 8, ncol =24 ) ## + ylim(0,400)
plt <- plt + stat_summary(fun = "mean", geom="line", size = 1, position=position_dodge(0))  
plt <- plt + stat_summary(fun.data="mean_se", geom="errorbar", width=0.5) + theme_light()

pdf(file = "plt.pdf", width = 7, height = 14)
plt
dev.off()
##END BACTERIA#####################
######################################################################

ggplot(myrichness_fin, aes(stage, ACE, group = year, colour = year)) + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) + stat_summary(fun.data="mean_se", geom="errorbar", width=0.5) + theme_light()


## + ylim(0,400)
plt <- plt + stat_summary(fun = "mean", geom="line", size = 1, position=position_dodge(0))  
plt <- plt + stat_summary(fun.data="mean_se", geom="errorbar", width=0.5) + theme_light()

## plot some alpha diversity indices
plot_richness(MUST_Fungi_RIS3_2020.2021.4thStage, x="stage", measures=c("InvSimpson"), color="year", "vinification") + facet_wrap(~terroir_vinification + year, scales = "fixed")

plot_richness(MUST_Fungi_RIS3_2020.2021.4thStage, x="stage", measures=c("InvSimpson"), color="year", "vinification") + facet_wrap(~terroir_vinification + variety, scales = "free_x")



plot_richness(MUST_Fungi_RIS3_2020.2021.C.A, x="stage", measures=c("InvSimpson"), color="year") + facet_wrap(~terroir_vinification, scales = "free_x", nrow = 2) + geom_boxplot(alpha=0.6) + stat_summary(fun=mean, geom="pointrange", shape=23, size=4)





+ geom_boxplot(alpha=0.6) + stat_compare_means(method = "wilcox.test", comparisons = a_my_comparisons, label = "p.signif", symnum.args = symnum.args)


a_my_comparisons <- list( c(c("RoditisTerA","RoditisTerB"), c("RoditisTerA","SideritisTerA")), c("RoditisTerA", "SideritisTerB"), c("RoditisTerB", "SideritisTerA"), c("RoditisTerB", "SideritisTerB"))
symnum.args = list(cutpoints = c(0, 0.0001, 0.001, 0.01, 0.05, 1), symbols = c("****", "***", "**", "*", "ns"))

plot_richness(MUST_Fungi_RIS3_2020.2021.4thStage, x="stage", measures=c("InvSimpson"), color="year") + facet_wrap(~terroir, scales = "free_x", nrow = 2)  +
  geom_boxplot(alpha=0.6) + stat_summary(fun=mean, geom="point", shape=23, size=4) + geom_dotplot()

  stat_compare_means(method = "wilcox.test", comparisons = a_my_comparisons, label = "p.signif", symnum.args = symnum.args)
+ 
  theme(legend.position="none", axis.text.x=element_text(angle=45,hjust=1,vjust=1,size=12))


+
  stat_compare_means(method = "mystatsout") 


plot_richness(MUST_Fungi_RIS3_2020.2021.4thStage, x="stage", measures=c("InvSimpson"), color="year") + geom_bar(stat="identity", width = 0.25) + facet_wrap(~terroir_vinification, scales = "fixed")



plot_richness(GlobalPatterns, title = “Global Patterns Alpha Diversity”, measures = c(“Shannon”), color = “SampleType”) +
  facet_wrap(~SampleType, scales = “free_x”)

+ facet_grid(cols = vars(terroir_vinification), rows = vars(year))

plot_richness(VINE_ITS_ROADS_2020.2021., x="terroir", measures=c("Shannon","Simpson","Fisher","Observed","Chao1","ACE","InvSimpson"), color="variety")

title = "Assyrtiko_HighRooted Bacteria")






###################ALPHADIVERSITY FULL ANALYSIS##################
MUST_Fungi_RIS3_2020.2021.C.A_Merged
MUST_Fungi_RIS3_2020.2021.4thStage

adiv <- plot_richness(MUST_Fungi_RIS3_2020.2021.4thStage, measures=c("Observed","InvSimpson"))

adiv <- plot_richness(MUST_Fungi_RIS3_2020.2021.4thStage, x="stage", measures=c("InvSimpson"), color="stage", shape ="vinification")


## calculate Good's coverage estimate as well
install.packages("entropart")
library(entropart)

good <- MetaCommunity(t(MUST_Fungi_RIS3_2020.2021.4thStage@otu_table))$SampleCoverage.communities

good_tbl <- data.frame(samples = names(good), variable = rep("coverage",length(good)), value=good)

alpha_long <- rbind(adiv$data[,c("samples", "variable", "value")], good_tbl)

# convert long to wide
library(reshape2)
alpha_wide <- dcast(alpha_long, samples ~ variable, value.var="value")
row.names(alpha_wide) <- alpha_wide$samples

alpha_wide <- alpha_wide[,c("Observed","InvSimpson")]

colnames(alpha_wide) <- c("Observed","InvSimpson")

alpha_wide_fact <- merge(alpha_wide, data.frame(sample_data(MUST_Fungi_RIS3_2020.2021.4thStage)), by = "row.names")

row.names(alpha_wide_fact) <- alpha_wide_fact$Row.names
alpha_wide_fact <- alpha_wide_fact[-which(colnames(alpha_wide_fact)%in%"Row.names")]
alpha_wide_fact$terroir <- factor(alpha_wide_fact$terroir)

library("agricolae")
#### perform anova or equivalent for the alpha diversity indices ----

##### from
mytestvars <- colnames(alpha_wide)[2:1]


library("agricolae")

mystatsout <- list()

mytestfacts <- colnames(alpha_wide_fact[,7:ncol(alpha_wide_fact)])

for(mytestfact in mytestfacts){
  cairo_pdf(paste("alpha_div_plot_",mytestfact,".pdf", sep = ""), height = 3, width = 9, onefile = T)
  par(mfrow = c(2,3))
  for(mytestvar in mytestvars){
    
    
    
    # create the aov matrix
    myaovmatrix <- alpha_wide_fact
    
    # run a shapiro wilk test to select parametric or non parametric analysis
    shap_out <- shapiro.test(myaovmatrix[,mytestvar])
    mystatsout[[paste(mytestvar, sep = " // ")]][["shap"]] <- shap_out
    
    # run the parametric or non-parametric analysis according to the shapiro.test results
    if(shap_out$p.value < 0.05){
      # non-parametric
      mykrusk <- kruskal(myaovmatrix[,mytestvar], myaovmatrix[,mytestfact], group = T, p.adj = "BH")
      
      mystatsout[[paste(mytestvar, sep = " // ")]][["krusk"]] <- mykrusk
      # prepare the barplot
      #mytestvarord <- c("Control","Karla","MC2","MC12","Karla + MC12")
      myaovmatrix[,mytestfact] <- factor(myaovmatrix[,mytestfact])
      mytestvarord <- levels(myaovmatrix[,mytestfact])
      par(mar = c(2,10,4,2))
      barerrplt <- bar.err(mykrusk$means[mytestvarord[length(mytestvarord):1],], variation="SD", xlim=c(0,1.2*max(mykrusk$means[mytestvarord[length(mytestvarord):1],1] + mykrusk$means[mytestvarord[length(mytestvarord):1],3])),horiz=TRUE, bar=T, col="grey60", space=1, main= paste(mytestvar), las=1)
      #mypltmt <- data.frame(myHSDtest$means[mytestvarord,1:2],sigletters = myHSDtest$groups[mytestvarord,"groups"], check.names = F)
      
      # delete the significance group letters in the case that the anova was not significant
      par(xpd = T)
      if(mykrusk$statistics$p.chisq <= 0.05){
        text(x = mykrusk$means[mytestvarord[length(mytestvarord):1],1] + mykrusk$means[mytestvarord[length(mytestvarord):1],3], barerrplt$x,labels = mykrusk$groups[mytestvarord[length(mytestvarord):1],2], pos = 4, font = 3)
        par(xpd = F)
      }
    } else { 
      # perform the parametric
      
      # select the alphadiv matrix and design rows
      myform <- as.formula(paste("`",mytestvar,"` ~ ",mytestfact, sep = ""))
      mymod <- aov(myform, data = myaovmatrix)
      mysumaov <- summary(mymod)
      
      mystatsout[[paste(mytestvar, sep = " // ")]][["ANOVA"]] <- mysumaov
      
      # order the matrices etc
      mytestvarord <- levels(factor(myaovmatrix[,mytestfact]))
      
      # run the Tukey test
      myHSDtest <- HSD.test(mymod, mytestfact, group=T)
      
      mystatsout[[paste(mytestvar, sep = " // ")]][["HSD test"]] <- myHSDtest
      
      # prepare the barplot
      par(mar = c(2,10,4,2))
      barerrplt <- bar.err(myHSDtest$means[mytestvarord[length(mytestvarord):1],], variation="SD", xlim=c(0,1.2*max(myHSDtest$means[mytestvarord[length(mytestvarord):1],1] + myHSDtest$means[mytestvarord[length(mytestvarord):1],2])),horiz=TRUE, bar=T, col="grey60", space=1, main= paste(mytestvar), las=1)
      #mypltmt <- data.frame(myHSDtest$means[mytestvarord,1:2],sigletters = myHSDtest$groups[mytestvarord,"groups"], check.names = F)
      
      # delete the significance group letters in the case that the anova was not significant
      par(xpd = T)
      if(mysumaov[[1]]$`Pr(>F)`[1] <= 0.05){
        text(x = myHSDtest$means[mytestvarord[length(mytestvarord):1],1] + myHSDtest$means[mytestvarord[length(mytestvarord):1],2], barerrplt$x,labels = myHSDtest$groups[mytestvarord[length(mytestvarord):1],2], pos = 4)
        par(xpd = F)
      }
    }
    
    
  }
  dev.off()
}

capture.output(mystatsout,file = paste("alpha_div_stats_",mytestfact,".txt", sep = ""))
##### till here