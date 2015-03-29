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

strange <- italia[italia$LONG > 25,]
lon = strange$LONG
lat = strange$LAT
df <- as.data.frame(cbind(lon,lat))
mapgilbert <- get_map(location = c(lon = mean(df$lon), lat = mean(df$lat)), zoom = 4,
                      maptype = "satellite", scale = 2)
ggmap(mapgilbert) +
  geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 0.8), size = 5, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)

require(maptools)
library(rgeos)
library(rgdal)
shape <- readShapePoly("reg2011_g.shp")
#+proj=utm +zone=32 +ellps=intl +units=m +no_defs
plot(shape)

shape@proj4string <- CRS("+proj=utm +zone=32 +ellps=intl +units=m +no_defs")

point <- data.frame(lon=lon[1], lat=lat[1])
sp2   <- SpatialPoints(point,proj4string=CRS("+proj=longlat +datum=WGS84"))
sp2 <- spTransform(sp2, CRS("+proj=utm +zone=32 +ellps=intl +units=m +no_defs"))
gContains(shape,sp2)