## facet wrapped box plot
# for Alpha divesity (sobs; coverage and inv simp)


library(ggplot2)
library(grid)
library(reshape2)
library(ggthemr)

d = read.table("LimeAllAlphaDiv2.txt", sep = "\t", row.names=1, header=T)

# # what data looks like (head(d)):
# group     Growth NucType   variable        value
# 1   D1Highplot1a_DNA Elongation     DNA   coverage     0.921939
# 2   D1Highplot1b_DNA Elongation     DNA   coverage     0.962580
# 3   D1Highplot2a_DNA Elongation     DNA   coverage     0.969639
# 4   D1Highplot2b_DNA Elongation     DNA   coverage     0.965735

# put data in right form:
dm <- melt(d)


dm[["NucType"]] <- setFactorOrder(dm[["NucType"]], c("DNA", "cDNA"))

## looks like this when do head(dm)
# group     Growth NucType variable    value
# 1 D1Highplot1a_DNA Elongation     DNA coverage 0.921939
# 2 D1Highplot1b_DNA Elongation     DNA coverage 0.962580
# 3 D1Highplot2a_DNA Elongation     DNA coverage 0.969639
# 4 D1Highplot2b_DNA Elongation     DNA coverage 0.965735
# 5 D1Highplot3a_DNA Elongation     DNA coverage 0.935806
# 6 D1Highplot3b_DNA Elongation     DNA coverage 0.940325

## Now plot changing variables as approriate


c <- ggplot(dm, aes(factor(Growth), value, fill = factor(NucType))) +
  
  ## + geom_boxplot so it knows what type of plot
  # and put colour = black to make lines of box black. 
  
  geom_boxplot(colour="black") 

# now do facet wrap to make 3 separate plots for sobs; coverage and invsimp:

d <- c + facet_wrap(~variable, scales = "free") + coord_flip()

# or put free_x if your x axis is the same for all plots so you
# only wanted it shown once. 

deep <- c + facet_wrap(~variable, scales = "free_x") + coord_flip()


# change facet labels.
#1. define new names where names on left are current ones
# and ones on right of = are new ones. \n means enter

Alpha_names <- c(
  `coverage` = "Coverage \n",
  `sobs` = "OTUs \nobserved \n",
  `invsimpson` = "Inverse \nsimpson \n"
)


# do facet wrap again adding labeller argument
re <- c + facet_wrap(~variable, labeller = as_labeller(Alpha_names), scales = "free_x") + coord_flip()


rep <- re + labs(fill=" ") +


  
  ## specify labels for axes and plot title if required
  
theme_bw() +
  
  
  ## change text size and placing of axes and titles
  ## ensure , at end of each line 
  ## legend.key.size changes size of legend and required 'grid' package to be loaded for unit() to work
  
  theme(axis.text.x=element_text(size=15, vjust=0.5, colour = "black"), 
        axis.text.y=element_text(size=18, vjust=0.5, colour = "black"),
        #axis.title.y=element_text(size=18, vjust=1, colour="black"),
        legend.text=element_text(size=18, vjust=0.5),
        legend.key.size=unit(2, "cm"),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        strip.text.x = element_text(size = 18, colour = "black"),# change font of facet label
        strip.background =  element_rect(fill = "white") ) # remove grey backgroup of facet label

rep

## changing facet labels help from here
# https://stackoverflow.com/questions/3472980/ggplot-how-to-change-facet-labels

# help dropping repeat x axis labels:

# https://stats.stackexchange.com/questions/24806/dropping-unused-levels-in-facets-with-ggplot2