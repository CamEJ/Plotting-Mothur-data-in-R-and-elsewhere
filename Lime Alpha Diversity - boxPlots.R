## Box and whisker plot - Lime Alpha Diversity

d = read.table("LimeAllAlphaDiv.txt", sep = "\t", row.names=1, header=T)

## load ggplot

library(ggplot2)
library(grid)

## also ran gthemer to put my WP3 colours to give same
## four colours to my four treatments as for the other plots. 

## need to run setFactorOrder function before doing these two commands. 
# keep samples in order ie DNA then cDNA

d[["NucType"]] <- setFactorOrder(d[["NucType"]], c("DNA", "cDNA"))



## d = data
library(ggthemr)

##### set two colours i liked as palette using ggthemr (and for this one my fill was only going
## to be one of two colours (one for DNA and one for cDNA)


dark_cols <- c("black", "lightslateblue", "gray3")
DarkCols1 <- c("#555555", dark_cols)
# remove previous effects:
ggthemr_reset()
# Define colours for your figures with define_palette
darkCols <- define_palette(
  swatch = DarkCols1, # colours for plotting poits and bars
  gradient = c(lower = DarkCols1[1L], upper = DarkCols1[2L]), #upper and lower colours for continuous colours
  background = "white" #defining a grey-ish background 
)
# set the theme for your figures:
ggthemr(darkCols)

####

ggplot(d, aes(factor(Growth), invsimpson, fill = factor(NucType))) +
  
  ## + geom_boxplot so it knows what type of plot
  # and put colour = black to make lines of box black. 
  
  geom_boxplot(colour="black") +
  
  ## scale_fill_manual to give different from default colour
  ## name argument gives legend title
  ## colours: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
  ## if you didnt use gthemr to set colour scheme and manually want to choose colour then alter the
  ## following and uncomment it. 
  
  #scale_fill_manual(name = "Treatment", values = c("royalblue2", "green4", "yellow", "purple")) +
  
  ## theme_bw() to make background white
  theme_bw() + 
  
  ## specify labels for axes and plot title if required
  
  labs(y="Inverse Simpson", fill=" ") +

  
  ## change text size and placing of axes and titles
  ## ensure , at end of each line 
  ## legend.key.size changes size of legend and required 'grid' package to be loaded for unit() to work
  
  theme(axis.text.x=element_text(size=18, vjust=0.5, colour = "black"), 
        axis.text.y=element_text(size=16, vjust=0.5, colour = "black"),
         axis.title.y=element_text(size=18, vjust=1, colour="black"),
        legend.text=element_text(size=18, vjust=0.5),
        legend.key.size=unit(2, "cm"),
          axis.title.x=element_blank()  ) 


#### now plots sobs#####


ggplot(d, aes(factor(Growth), sobs, fill = factor(NucType))) +
  
  ## + geom_boxplot so it knows what type of plot
  # and put colour = black to make lines of box black. 
  
  geom_boxplot(colour="black") +
  
  ## scale_fill_manual to give different from default colour
  ## name argument gives legend title
  ## colours: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
  ## if you didnt use gthemr to set colour scheme and manually want to choose colour then alter the
  ## following and uncomment it. 
  
  #scale_fill_manual(name = "Treatment", values = c("royalblue2", "green4", "yellow", "purple")) +
  
  ## theme_bw() to make background white
  theme_bw() + 
  
  ## specify labels for axes and plot title if required
  
  labs(y="Number of OTUs observed", fill=" ") +
  
  
  ## change text size and placing of axes and titles
  ## ensure , at end of each line 
  ## legend.key.size changes size of legend and required 'grid' package to be loaded for unit() to work
  
  theme(axis.text.x=element_text(size=18, vjust=0.5, colour = "black"), 
        axis.text.y=element_text(size=16, vjust=0.5, colour = "black"),
        axis.title.y=element_text(size=18, vjust=1, colour="black"),
        legend.text=element_text(size=18, vjust=0.5),
        legend.key.size=unit(2, "cm"),
        axis.title.x=element_blank()  ) 

#### now plots coverage #####


ggplot(d, aes(factor(Growth), coverage, fill = factor(NucType))) +
  
  ## + geom_boxplot so it knows what type of plot
  # and put colour = black to make lines of box black. 
  
  geom_boxplot(colour="black") +
  
  ## scale_fill_manual to give different from default colour
  ## name argument gives legend title
  ## colours: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
  ## if you didnt use gthemr to set colour scheme and manually want to choose colour then alter the
  ## following and uncomment it. 
  
  #scale_fill_manual(name = "Treatment", values = c("royalblue2", "green4", "yellow", "purple")) +
  
  ## theme_bw() to make background white
  theme_bw() + 
  
  ## specify labels for axes and plot title if required
  
  labs(y="Sample coverage", fill=" ") +
  
  
  ## change text size and placing of axes and titles
  ## ensure , at end of each line 
  ## legend.key.size changes size of legend and required 'grid' package to be loaded for unit() to work
  
  theme(axis.text.x=element_text(size=18, vjust=0.5, colour = "black"), 
        axis.text.y=element_text(size=16, vjust=0.5, colour = "black"),
        axis.title.y=element_text(size=18, vjust=1, colour="black"),
        legend.text=element_text(size=18, vjust=0.5),
        legend.key.size=unit(2, "cm"),
        axis.title.x=element_blank()  ) 

