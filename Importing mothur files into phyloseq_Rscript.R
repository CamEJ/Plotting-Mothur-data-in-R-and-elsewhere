## reading Mothur files into Phyloseq
## install phyloseq this way


install.packages("devtools")
install.packages(Rtools.33)
source("https://bioconductor.org/biocLite.R")
biocLite("BiocInstaller")
library("devtools")
install_github("phyloseq", "joey711")

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
sharedFile = read.table("stability.an.shared") ## this takes a while (~20mins on big computer)

sharedFile = t(sharedFile) ## transform data
rownames(sharedFile) = sharedFile[,1]  ## define rowname
colnames(sharedFile) = sharedFile[2,]  ## define column names
sharedFile = sharedFile[,2:48]       ## say which columns you want (remember order [row,colum]) 2 -> 48 for me
## as I had 48 samples
sharedFile = sharedFile[4:289407,]     ## and which rows you want. I have 289407 OTUs so I changed this number to 289407
# original => sharedFile = sharedFile[4:37368,]
class(sharedFile) <- "numeric"

head(sharedFile) ## look at head first 7 lines to see it's made correclty


## Import subsampled otu matrix (26880 seqs)

sharedsubFile = read.table('stability.an.0.03.subsample.shared')
sharedsubFile = t(sharedsubFile)
rownames(sharedsubFile) = sharedsubFile[,1]
colnames(sharedsubFile) = sharedsubFile[2,]
sharedsubFile = sharedsubFile[,2:48]
sharedsubFile = sharedsubFile[4:26880,]
class(sharedsubFile) <- "numeric"
head(sharedsubFile)

## Import taxonomy file 
## As it is from mothur, there are not column headers for order, family genus etc
## in the cons.taxonomy file and this must be fixed first. This is how I did it:
## read cons.taxonomy file into excel and choose semicolon as a separator so each tax level
## is therefore in its own column. then delete header 'taxonomy' and put in appropriate
## header for each column (order or family or genus etc. 
## Copy and paste into notepad and save. Then carry on: 
taxFile = read.table('stability.Tdelim.taxonomy', header=T, sep='\t')
rownames(taxFile) = taxFile[,1]
taxFile = taxFile[,2:8]
taxFile = as.matrix(taxFile)
head(taxFile)

## import metadata file
metaFile = read.table('cDNA_metadata.txt', header=T, sep='\t')
rownames(metaFile) = metaFile[,1]
metaFile = metaFile[,2:3]
head(metaFile)



## Create phyloseq object

OTU = otu_table(sharedFile, taxa_are_rows = TRUE)
OTUsub = otu_table(sharedsubFile, taxa_are_rows = TRUE)
TAX = tax_table(taxFile)
META = sample_data(metaFile)
physeq = phyloseq(OTU, TAX, META)
physeqSub = phyloseq(OTUsub, TAX, META)
physeqSub

## Get rid of any OTUs not present in any samples and get relative abundance

#microSub <- prune_taxa(taxa_sums(physeqSub) > 0, physeqSub)
microSubRel = transform_sample_counts(microSub, function(x) x / sum(x) )
microSubRelFilt = filter_taxa(microSubRel, function(x) mean(x) > 1e-5, TRUE)

# for subsampled shared file
sharedSubRelAubd = transform_sample_counts(sharedsubFile, function(x) x / sum(x) )
