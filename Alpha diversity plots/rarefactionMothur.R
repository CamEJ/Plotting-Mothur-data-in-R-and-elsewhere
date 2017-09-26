# Plotting mothur rarefaction data
#  rarefaction.single() output file as used in Schloss SOP
# is file used for input


# read in rarefaction file

data <- read.table(file="stability.opti_mcc.0.03.pick.groups.rarefaction", header=T)

name <- read.table(file="shortNames.txt", header=T)

head(data) # take a look to check col and row names

# Now we want to choose just one column per sample as
# at the moment there are 3
# we'll use the ones starting with X0.03

# load dplyr

library(dplyr)

# now we'll tell R to use dplyr to make a new dataframe called boo
# containing only columns with the prefix "X0.03"
# if you wanna plot the HCI or LCi ones then
# change starts-with as appropriate.

boo <- select(data, starts_with("X0.03"))

# boo <- select(data, starts_with("hci"))

head(boo) # check all your samples are there.

names(boo) <- substring(names(boo), 7) # mothur adds that awful prefix to sample
                                        # name - use substring to remove where the no
                                        # represents which letter you want name to start on - here it's 7th letter
head(boo) # check you got it right

# now add numsampled row back in as this will be out y axis. 

boo$numsampled<- data$numsampled

head(boo) # check

# I have some crappy samples that failed the sequencing run and won't be analysed
# I am cutting out so i dont want to plot them,
# I'll remove them by name with subset()
boo1 = subset(boo, select=-c(T7_Tmt3_a,T3_Tmt3_c,NegC_DNA,NegC_cDNA))
head(boo1)

# change names to short as plot too messy with long names on
colnames(boo1) = name$short
head(boo1)


# and now to plotting

library(ggplot2)
library(reshape2)
library(directlabels)
library(RColorBrewer)


# first melt it then plot

booM = melt(boo1, id.vars="numsampled")
head(booM) # check

r <- ggplot() + 
  geom_line(data=booM, aes(x=numsampled, y=value, 
                              group=variable, colour=variable))
r

# with labels at the end of the lines: 

r = ggplot(booM, aes(x=numsampled, y=value, 
                 group=variable, colour=variable)) +
  geom_line(size = 0.8) + # define line thickness
  scale_colour_manual(values = colorRampPalette(brewer.pal(8, "Set1"))(90), # choose colour palette from colour brewer
                    guide = 'none') +
  geom_dl(aes(label = variable), 
          method = list(dl.combine("last.points"), colour= "black", cex = 1.2))


## add Title and axis labels to plot

r2 <- r +  labs(x="Number of Sequences", y = "Number of OTUs") +theme_bw() +
  theme(axis.text.x=element_text(size=12, vjust=0.5, color = "black"), 
        axis.text.y=element_text(size=12, vjust=0.5, color = "black"),
        axis.title.x=element_text(size=14, vjust=0.25, face = "bold", color="black"),
        axis.title.y=element_text(size=14, vjust=1, face = "bold", color="black")
  )

## print r2 to see new plot 
r2

#r3 <- r2 + theme(legend.position="none")
#r3



#======================== another version; from co-ex paper where only had 6 samples ------------------------


# set colours to use in line (i have 6 lines in this eg therefor 6 cols)
lineCol = c("red", "orange1", "blue4", "lightslateblue", "darkgreen", "seagreen1")

# plotting 
r <- ggplot() + 
  geom_line(data=booM, aes(x=numsampled, y=value, 
                              group=variable, colour=variable), size = 1.5) +
scale_colour_manual(values = lineCol, labels = c("DNA 1", "DNA 2", "DNA 3", "cDNA 1", "cDNA 2", "cDNA 3"))
# where label = c() is where you put new labels you want in legend
r

## axis labels to plot

r2 <- r +  labs(x="Number of Sequences", y = "Number of OTUs") 

## change background of plot to white with theme_bw() 
## remove legend title as there's no point

r3 <- r2 + theme_bw() +  theme(legend.title=element_blank())

r4 = r3 +   theme(legend.key = element_rect(size = 5),
                  legend.key.size = unit(1.5, 'lines')) 
                  
r4 + 
theme(axis.text.x=element_text(size=14, vjust=0.5, color = "black"), 
  axis.text.y=element_text(size=14, vjust=0.5, color = "black"),
  axis.title.x=element_text(size=16, vjust=0.25, face = "bold", color="black"),
  axis.title.y=element_text(size=16, vjust=1, face = "bold", color="black"),
  legend.text=element_text(size=16, vjust=0.5)
)



# print save as pdf
