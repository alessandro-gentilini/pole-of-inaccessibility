italia <- read.csv("it.txt",sep="\t",head=T)
str(italia)
lon = italia$LONG
lat = italia$LAT
coords <- data.frame(lon,lat)
coords <- unique(coords)
plot(lon,lat)
library(alphahull)
vor <- delvor(coords$lon,coords$lat)
plot(vor,wlines="vor")