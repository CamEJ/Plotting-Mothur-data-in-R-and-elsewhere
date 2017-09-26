## Box and whisker plot

d = read.table("WP3-invSimp.txt", sep = "\t", row.names=1, header=T)

## load ggplot

library(ggplot2)
library(grid)

## also ran gthemer to put my WP3 colours to give same
## four colours to my four treatments as for the other plots. 

## need to run setFactorOrder function before doing these two commands. 
# keep samples in order according to timepoint

d[["timepoint"]] <- setFactorOrder(d[["timepoint"]], c("T0", "T2", "T3", "T7", "T8", "T11", "T13"))

## and according to treatment. 
d[["Treatment"]] <- setFactorOrder(d[["Treatment"]], c("Control", "Slurry", "Flood", "Flood+Slurry"))



## d = data
## aes(factor(what you want on x axis), whatyouwantonYaxis, fill=factor(treatmentforeg))


ggplot(d, aes(factor(timepoint), invsimpson, fill = factor(Treatment))) +
  
  ## + geom_boxplot so it knows what type of plot
  
  geom_boxplot() +
  
  ## scale_fill_manual to give different from default colour
  ## name argument gives legend title
  ## colours: http://sape.inf.usi.ch/quick-reference/ggplot2/colour
  ## if you didnt use gthemr to set colour scheme and manually want to choose colour then alter the
  ## following and uncomment it. 
  
    #scale_fill_manual(name = "Treatment", values = c("royalblue2", "green4", "yellow", "purple")) +
             
  ## theme_bw() to make background white
    theme_bw() + 
   
  ## specify labels for axes and plot title if required
  
  labs(x="Sampling Day", y="Inverse Simpson Values") +
  
  ## change text size and placing of axes and titles
  ## ensure , at end of each line 
  ## legend.key.size changes size of legend and required 'grid' package to be loaded for unit() to work
  
                theme(axis.text.x=element_text(size=12, vjust=0.5), 
                      axis.text.y=element_text(size=12, vjust=0.5),
                      axis.title.x=element_text(size=16, vjust=0.25, face = "bold"),
                      axis.title.y=element_text(size=16, vjust=1, face = "bold"),
                      legend.title=element_text(size=16, vjust=1),
                      legend.text=element_text(size=15, vjust=0.5),
                      legend.key.size=unit(1.5, "cm")
                      ) 





