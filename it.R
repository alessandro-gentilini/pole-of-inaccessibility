pdf("italy.pdf")
require(ggplot2)
require(ggmap)
italia <- read.csv("it.txt",sep="\t",head=T)
lon = italia$LONG
lat = italia$LAT
coords <- data.frame(lon,lat)
coords <- unique(coords)
plot(lon,lat)
library(alphahull)
vor <- delvor(coords$lon,coords$lat)
plot(vor,wlines="vor")

# Answer by Jaap (http://stackoverflow.com/users/2204410/jaap)
# to question 'R plot coordinates on map'.
# http://stackoverflow.com/a/23143501/15485
df <- as.data.frame(cbind(lon,lat))
mapgilbert <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 4,
                      maptype = "satellite", scale = 2)
ggmap(mapgilbert) +
  geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 5, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)