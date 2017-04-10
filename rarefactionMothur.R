# Plotting mothur rarefaction data
#  rarefaction.single() output file as used in Schloss SOP
# is file used for input


# read in rarefaction file

data <- read.table(file="stability.an.groups.rarefaction", header=T)

# take a look to check col and row names
head(data)


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

# now tell it we want the rownames from original file to be
# column 1

boo$numsampled<- data$numsampled

head(boo) # check

# and now to plotting

library(ggplot2)
library(reshape2)

# first melt it then plot

booM = melt(boo, id.vars="numsampled")
head(booM) # check

r <- ggplot() + 
  geom_line(data=melted3, aes(x=numsampled, y=value, 
                              group=variable, colour=variable))
r

## add Title and axis labels to plot

r2 <- r +  labs(x="Number of Sequences", y = "Number of OTUs") 

## change background of plot to white with theme_bw()

## remove legend as there's no point

r3 <- r2 + theme_bw() +  theme(legend.position="none")

## print r3 to see new plot 
r3





