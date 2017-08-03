# Plotting lefse data

# library(ggplot2)

# also ran ggthemr WP1 cols to get correct colours per tmt

# Using lefse_summary file output from mothur, trim data to 
# p < 0.01 & then choose some cut off of LDA vals. I used LDA > 3

# in excel i had ordered this data accroding to treatment (ie sample day)
# and then within those groupings I ordered according to LDA score (big to small). 
# makes final plot pretier. Probably a very simple way to do this in R
# but I didnt have time to figure out how :?

# read in data. 

LF <- read.table("Lefse-cDNAwTax.txt", header = TRUE, sep="\t" )
head(LF)

# OTU     Growth     LDA  Nuc               Class                  Order
# 1 Otu000003 elongation 3.65574 cDNA Deltaproteobacteria           Myxococcales
# 2 Otu000004 elongation 3.63123 cDNA Alphaproteobacteria            Rhizobiales
# 3 Otu000005 elongation 3.52197 cDNA      Spartobacteria Spartobacteria unclass
# 4 Otu000006 elongation 3.41936 cDNA      Spartobacteria Spartobacteria unclass
# 5 Otu000007 elongation 3.28732 cDNA Alphaproteobacteria        Caulobacterales


# set order to be by order of OTUs in original file
LF$OTU <- factor(LF$OTU, levels = LF$OTU)

# in fact, i want rev of this as make plot easier to interpret
LF$OTU <- factor(LF$OTU, levels = rev(LF$OTU))



pt <- ggplot(LF, aes(x=OTU, y=LDA, fill=Growth), show_guide=FALSE) + 
  geom_bar(position="dodge",stat="identity") + 
  coord_flip() # flip it 90


# Replace OTU### with tax info:
# using concatenate in excel to add "" , faster, make this string of 
# tax info matching OTU id. Name this:


myLabscd <- c("Myxococcales", "Rhizobiales","Spartobacteria unclass","Spartobacteria unclass",
              "Caulobacterales","Sphingobacteriales","Sphingobacteriales","Caulobacterales",
              "Bacteria unclass","Acidobacteria Gp4 unclass","Pseudomonadales","Bacteria unclass",
              "Verrucomicrobia unclass","Acidobacteria Gp3  unclass","Myxococcales","Flavobacteriales",
              "Myxococcales","Myxococcales","Pseudomonadales","Verrucomicrobiales","Myxococcales",
              "Myxococcales","Myxococcales","Bacteroidetes unclass","Flavobacteriales",
              "Myxococcales","Bacteroidetes unclass","Bacteroidetes unclass","Acidobacteria Gp3  unclass",
              "Myxococcales"
)

# then add these labels to the to plot 

PTL <- pt + scale_x_discrete(labels= myLabscd)

## change font colour size etc

k = PTL + theme_bw() +
  theme(axis.text.x=element_text(hjust=1, size=15, vjust=0.4, colour="black")) +
  theme(axis.text.y=element_text(hjust=1, size=13, vjust=0.4, colour="black")) +
  theme(axis.title.y=element_blank()) +
  theme(axis.title.x=element_text(size=15, colour="black")) +
  labs(fill="  Growth Stage\n") +
  theme(legend.title =element_text(size=15, colour="black")) +
  theme(legend.text = element_text(size=13, colour="black")) +
  guides(fill = guide_legend(override.aes = list(size=13)))

k # print & save as pdf 

