## WP3 specific bacterial groups abundance w phyloseq 


## others can be installed using tools -> install packages on R studio
## If run into errors such as below the try this command:
## setInternet2(TRUE) 
## "Cannot open compressed file 'knitr/DESCRIPTION', probable reason 'No such file or directory'"

library("phyloseq")
library("ggplot2")
library("plyr")
library("vegan")
library("grid")
library("directlabels")
library("knitr")
library("clustsig")
library("ellipse")



## import data 
sharedsubFile <- sharedFile


## Import subsampled otu matrix (53555 seqs)

sharedsubFile = read.table('subsample.shared')
sharedsubFile = t(sharedsubFile)
rownames(sharedsubFile) = sharedsubFile[,1]
colnames(sharedsubFile) = sharedsubFile[2,]
sharedsubFile = sharedsubFile[,2:70]
sharedsubFile = sharedsubFile[4:28815,]
class(sharedsubFile) <- "numeric"
head(sharedsubFile)

## Import taxonomy file 
## As it is from mothur, there are not column headers for order, family genus etc
## in the cons.taxonomy file and this must be fixed first. This is how I did it:
## read cons.taxonomy file into excel and choose semicolon as a separator so each tax level
## is therefore in its own column. then delete header 'taxonomy' and put in appropriate
## header for each column (order or family or genus etc. 
## Copy and paste into notepad and save. Then carry on: 
taxFile = read.table('headed_cons.taxonomy', header=T, sep='\t')
rownames(taxFile) = taxFile[,1]
taxFile = taxFile[,2:8]
taxFile = as.matrix(taxFile)
head(taxFile)

## import metadata file
metaFile = read.table('DNA.metadata.txt', header=T, sep='\t')
rownames(metaFile) = metaFile[,1]
metaFile = metaFile[,2:6]
head(metaFile)



## Create phyloseq object

#OTU = otu_table(sharedFile, taxa_are_rows = TRUE)
OTUsub = otu_table(sharedsubFile, taxa_are_rows = TRUE)
TAX = tax_table(taxFile)
META = sample_data(metaFile)
#physeq = phyloseq(OTU, TAX, META)
physeqSub = phyloseq(OTUsub, TAX, META)
head(physeqSub)

## Get rid of any OTUs not present in any samples and get relative abundance

microSub <- prune_taxa(taxa_sums(physeqSub) > 0, physeqSub)
microSubRel = transform_sample_counts(microSub, function(x) x / sum(x) )
microSubRelFilt = filter_taxa(microSubRel, function(x) mean(x) > 1e-5, TRUE)

# for subsampled shared file
#sharedSubRelAubd = transform_sample_counts(sharedsubFile, function(x) x / sum(x) )


library(ggplot2)

## filter for nitrifyers

#genera: Nitrosomonas, Nitrosococcus, Nitrobacter and Nitrococcus

## look Nitrosomonas
microSubRelNitrosomonas = subset_taxa(microSubRel, Genus=="Nitrosomonas(100)")
BarNitrosom <- plot_bar(microSubRelNitrosomonas, fill="Genus", title="Nitrosomonas")
## changes scale/day so cant see difference really so just use all together
BarNitrosom + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))

Nitrosomonadaceae_unclassified

## look Nitrosospira
microSubRelNitroSpira = subset_taxa(microSubRel, Genus=="Nitrosospira(100)")
BarNitroSpira <- plot_bar(microSubRelNitroSpira, fill="Genus", title="Nitrosospira")
## changes scale/day so cant see difference really so just use all together
BarNitroSpira + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))



#Nitrosomonadaceae(100)
## look family Nitrosomonadaceae(100)
microSubRelNitrosomads = subset_taxa(microSubRel, Family=="Nitrosomonadaceae(100)")
BarNitrosomads <- plot_bar(microSubRelNitrosomads, fill="Genus", title="Nitrosomonadaceae")
## changes scale/day so cant see difference really so just use all together
BarNitrosomads + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))


### copio and oligotrophs


# Acidobacteria(100)
## look phylum Acidobacteria(100)
microSubRelAcido = subset_taxa(microSubRel, Phylum=="Acidobacteria(100)")
BarAcido <- plot_bar(microSubRelAcido, fill="Class", title="Acidobacteria")
## changes scale/day so cant see difference really so just use all together
BarAcido + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))


# Bacteroidetes(100)
## look phylum Bacteroidetes(100)
microSubRelBacto = subset_taxa(microSubRel, Phylum=="Bacteroidetes(100)")
BarBacto <- plot_bar(microSubRelBacto, fill="Class", title="Bacteroidetes")
## changes scale/day so cant see difference really so just use all together
BarBacto + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))

# Betaproteobacteria(100)
## look class Betaproteobacteria(100)
microSubRelBetaP = subset_taxa(microSubRel, Class=="Betaproteobacteria(100)")
BarBetaP <- plot_bar(microSubRelBetaP, fill="Order", title="Betaproteobacteria")
## changes scale/day so cant see difference really so just use all together
BarBetaP + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))

