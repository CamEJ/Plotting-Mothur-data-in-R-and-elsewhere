# Plotting stacked barplot of 20 most abundant OTUs
# using text version of biom table made in mothur

##Install packages, set working dir etc.

#install.packages(c("ggplot2", "stringr", "reshape2", "grid"))
                 
library(ggplot2)
library(stringr)
library(reshape2)
library(grid)

# read in otu table
# if you've already deleted first nonsense row then leave
# skip=1 arguement out of of this command
otu = read.table("CoExBiom.txt", sep = "\t", row.names=1, header=T, check.names=F, comment.char="", skip = 1)

OTUID = str_c(str_extract(otu$ConsensusLineage, "[^;]+$"),"_",row.names(otu))
rownames(otu) = OTUID
otu = otu[,-c(length(names(otu)))]

#Subselect OTUs and rearrange data - iterated stacked bar gets big pretty quickly, so I'm only plotting most abundant.
top.otus = as.data.frame(head(sort(rowSums(otu), decreasing = T),20))

otu.20 = otu[rownames(top.otus),]
otu.20.melt = melt(cbind(rownames(otu.20),otu.20))
colnames(otu.20.melt)[1] = "OTU"
colnames(otu.20.melt)[2] = "Sample"
colnames(otu.20.melt)[3] = "Abundance"

#As an alternative use percent abundance and then subselect the top 20 most abundant OTUs
s_num<-dim(otu)[2]
otu.perc<-matrix(rep("NA",times=(dim(otu)[1]*s_num)),nrow=dim(otu)[1],ncol=s_num)
rownames(otu.perc)<-rownames(otu)
colnames(otu.perc)=colnames(otu) 
totals<-colSums(otu)


#Embarassing for loop could be made better with one of the apply type commands?
for(s in c(1:s_num)){
  vec<-(otu[,s]/totals[s])*100
  otu.perc[,s]<-vec
  rm(vec)
}



write.table(otu.perc, "otu_perc.txt", col.names = NA, row.names = T, sep = "\t")
otu.perc = read.table("otu_perc.txt", sep = "\t", row.names=1, header=T, check.names=F)

otu.20.perc = otu.perc[rownames(top.otus),]
otu.20.melt.perc = melt(cbind(rownames(otu.20.perc),otu.20.perc))

colnames(otu.20.melt.perc)[1] = "OTU"
colnames(otu.20.melt.perc)[2] = "Sample"
colnames(otu.20.melt.perc)[3] = "Abundance"

## plotting otu.20.perc

# make a nice colour palette based on no of OTUs in
# otu.20.melt.perc

library(RColorBrewer)


colourCount =  length(unique(otu.20.melt.perc$OTU))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))



ggplot() + geom_bar(aes(x=Sample, y = Abundance, fill=OTU), data = otu.20.melt.perc,
                    stat="identity") +
  scale_fill_manual(values = getPalette(colourCount))

## plotting otu.20

colourCount =  length(unique(otu.20.melt$OTU))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))



ggplot() + geom_bar(aes(x=Sample, y = Abundance, fill=OTU), data = otu.20.melt,
                    stat="identity") +
  scale_fill_manual(values = getPalette(colourCount))




