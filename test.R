library(rgdal)
library(ggplot2)

map <- readOGR(dsn=".", layer="reg2011_g", p4s="+proj=utm +zone=32 +ellps=intl +units=m +no_defs")
map <- spTransform(map, CRS("+proj=longlat +datum=WGS84"))

er <- map[8,]

plot(er)

 

point <- data.frame(lon=11.7, lat=44.35 )
sp2   <- SpatialPoints(point,proj4string=CRS("+proj=longlat +datum=WGS84"))
plot(sp2,add=TRUE)
library(rgeos)
print(gContains(er,sp2))
print(gContains(map,sp2))

italia <- read.csv("it.txt",sep="\t",head=T)

points <- data.frame(lon=italia$LONG,lat=italia$LAT)
sp2   <- SpatialPoints(points,proj4string=CRS("+proj=longlat +datum=WGS84"))
# plot(map)
# for ( i in seq(1,length(sp2)) ) {
#   if(gContains(map,sp2[i])==FALSE){
#     plot(sp2[i],add=TRUE)
#   }
# }

plot(map)
for ( i in seq(1,nrow(italia)) ) {
  query_point_df <- data.frame(lon=italia[i,]$LONG,lat=italia[i,]$LAT)
  query_point <- SpatialPoints(query_point_df,proj4string=CRS("+proj=longlat +datum=WGS84"))
  if(gContains(map,query_point)==FALSE){
    plot(query_point,add=TRUE)
    print(italia[i,]$FULL_NAME_ND_RO,max.levels=0)
  }
}