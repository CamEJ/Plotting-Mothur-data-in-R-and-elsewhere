## Total abundance plot


AllT <- read.csv("untrimmedPhyloseqOTU.csv", header = TRUE)

# run setFactorOrder function - save in R basics folder
# this keeps subplots in correct order when plotted

AllT[["SamplingTime"]] <- setFactorOrder(AllT[["SamplingTime"]], c("T0", "T2", "T3", "T7", "T8", "T11", "T13"))

AllT[["Treatment.A"]] <- setFactorOrder(AllT[["Treatment.A"]], c("Control", "Slurry", "Flood", "Flood+Slurry"))

# make sure a dframe
m_df <- tbl_df(AllT)

# using colour brewer make a palette
mypal <- colorRampPalette( brewer.pal( 11 , "Spectral" ) )
intercalate <- function(n){ #my crude attempt to shuffle the colors
  c(rbind(1:(n/2), n:(n/2+1))) #it will only work for even numbers
}

## now plot
# change as appropritae:
# x=
# y=
# fill = 
# facet_wrap(SamplingTime) # this is if you want subplots of tmt or day eg.

ggplot(m_df, aes(x=Sample, y=Abundance, fill=Phylum)) + 
  geom_bar(stat="identity") + 
  facet_wrap(~SamplingTime, scales="free") + 
  scale_fill_manual( values = mypal(30)[intercalate(30)] )
# change this 30 as appropriate for the number of phylum (or whatever)
# in bar plot. Put very high ~100 at first if you dont know. 
  theme_bw() +
  theme(axis.text.x=element_text(angle=50, size=6))

# labels not really working properly - need to fix. 
  

# old way. Labels work on this one. colours not great though
Bar3 <- plot_bar(m_df, fill="Phylum")

Bar3b <- Bar3 + facet_wrap(~SamplingTime, scales="free") + theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1, size=9, vjust=0.4))
Bar3b



## if you want to define colours yourself, use ggthemr
library(ggthemr)

## choose colours from ggplot palette names
# 12 colours
abund_cols <- c("aquamarine3", "blueviolet", "darkorange1", "cornflowerblue", "darkgreen", "darkred", "goldenrod1", "deeppink4", "darkslateblue", "olivedrab3", "lightcoral", "navyblue")

# you have to add a colour at the start of your palette for outlining boxes, we'll use a grey:
abundCols <- c("#555555", abund_cols)
# remove previous effects:
ggthemr_reset()
# Define colours for your figures with define_palette

DCols <- define_palette(
  swatch = abundCols, # colours for plotting points and bars
  gradient = c(lower = abundCols[1L], upper = abundCols[2L]), #upper and lower colours for continuous colours
  background = "white" #defining a grey-ish background 
)

# set the theme for your figures:
ggthemr(DCols)
# now plot away!! 

## 20 colours
abund_cols <- c("aquamarine3", "blueviolet", "darkorange1", "cornflowerblue", "darkgreen", "darkred", "goldenrod1", "deeppink4", "darkslateblue", "olivedrab3", "lightcoral", "navyblue", "violet", "darkorchid4", "tomato", "slategray3", "yellow", "violetred1", "brown4")


