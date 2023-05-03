##Alpha Diversity analysis######

##load phyloseq object for bacteria, (the XXXXXX.RDS File from the construcrion of the phyloseq object raw counts)##

bacteria_vinification_Annotated   

adiv <- plot_richness(bacteria_vinification_Annotated, x="stage", measures=c("InvSimpson"), color="stage", shape ="vinification")

## calculate Good's coverage estimate as well
install.packages("entropart")
library(entropart)

good <- MetaCommunity(t(bacteria_vinification_Annotated@otu_table))$SampleCoverage.communities

good_tbl <- data.frame(samples = names(good), variable = rep("coverage",length(good)), value=good)

alpha_long <- rbind(adiv$data[,c("samples", "variable", "value")], good_tbl)

# convert long to wide
library(reshape2)
alpha_wide <- dcast(alpha_long, samples ~ variable, value.var="value")
row.names(alpha_wide) <- alpha_wide$samples

alpha_wide <- alpha_wide[,c("Observed","Shannon")]

colnames(alpha_wide) <- c("Observed","Shannon")

alpha_wide_fact <- merge(alpha_wide, data.frame(sample_data(bacteria_vinification_Annotated)), by = "row.names")

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
