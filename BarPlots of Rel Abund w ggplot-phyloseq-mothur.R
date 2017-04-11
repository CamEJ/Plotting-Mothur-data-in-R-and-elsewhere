

## Making Bar Plots of relative abundance

## Need to follow script "Importing mothur files into phyloseq"
## so you load right libraries and right files. 
## loading files takes a while. 
## again, modified this from:
## https://github.com/neavemj/MicrobimePlots/blob/master/spist.Rmd


## this first plot is for rank abundance plot
barplot(sort(taxa_sums(microSubRelFilt),TRUE)[1:100]/nsamples(microSubRelFilt),las=2,names.arg="",cex.axis=.7)

title(main="Rank Abundance plot - cDNA")
title(ylab="Relative Abundance") 


## now for abundance plot first filter out too low no.s or there is too much in barplot

microSubRelFiltFilt = filter_taxa(microSubRelFilt, function(x) mean(x) > 1e-2, TRUE)

## fill by class, order, family, as you like!
Bar3 <- plot_bar(microSubRelFiltFilt, fill="Class")


Bar2 <- plot_bar(microSubRelFiltFilt, fill="Order") 


## to split by day (ie 3 separate graphs by day)
## + theme_bw to remove grey background on plots
## when you do theme_bw it messes up axes so you have to move them
## back with theme(axis.text)
Bar2 + facet_wrap(~SampleDay, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, size=9, vjust=0.4, hjust=1))

Bar3b <- Bar3 + facet_wrap(~SampleDay, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))



## look pseudomonas
microSubRelFiltPseudomonas = subset_taxa(microSubRelFilt, Genus=="Pseudomonas(100)")
BarPseudoM <- plot_bar(microSubRelFiltPseudomonas, fill="Genus", title="Pseudomonas")
## changes scale/day so cant see difference really so just use all together
BarPseudoM + facet_wrap(~SampleDay, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))




## look Actinomycetales(100)
microSubRelFiltActin = subset_taxa(microSubRelFilt, Order=="Actinomycetales(100)")
BarActin <- plot_bar(microSubRelFiltActin, fill="SampleDay", title="Actinomycetales Abundance")
## changes scale/day so cant see difference really so just use all together
BarActin +  theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))

BarActin



## look Streptomycetaceae(100)
microSubRelFiltStrep = subset_taxa(microSubRelFilt, Family=="Streptomycetaceae(100)")
BarStrep <- plot_bar(microSubRelFiltActin, fill="SampleDay", title="Streptomycetaceae Abundance")
## facet wrap changes scale/day so cant see difference really so just use all together
BarStrep +  theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))


## look Bacillus(68)
microSubRelFiltBac = subset_taxa(microSubRelFilt, Genus=="Bacillus(68)")
BarBac <- plot_bar(microSubRelFiltBac, fill="SampleDay", title="Bacillus Abundance")
## facet wrap changes scale/day so cant see difference really so just use all together
BarBac +  theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))




scale_color_brewer(palette="Set1") 

BarPseudoM <- plot_bar(microSubRelFiltPseudomonas, fill="SampleDay", title="Pseudomonas")

BarPseudoM + geom_bar(aes(fill="SampleDay"))

BarPseudoM + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))


## look Rhizobiales(100)
microSubRelFiltRhizo = subset_taxa(microSubRelFilt, Order=="Rhizobiales(100)")
BarRhizo <- plot_bar(microSubRelFiltRhizo, fill="SampleDay", title="Rhizobiales Abundance")
## facet wrap changes scale/day so cant see difference really so just use all together
BarRhizo +  theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))

