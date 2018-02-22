library(dplyr)
library(readxl)
library(geosphere)
library(mapproj)
library(maptools)
library(sp)


# 1.
data1 = read.delim('1.data.txt', header = TRUE, sep = "\t")

#red = bottom 10 % of max range
#green = bottom 10 % of min range
#blue = bottom 10 % of both range

map()
idx_max_10 = data1$rank_max == 0
idx_min_10 = data1$rank_min == 0

coord_max = mapproject(data1$lon[idx_max_10], data1$lat[idx_max_10])
points(coord_max, col=rgb(1, 0, 0, 0.5))

coord_min = mapproject(data1$lon[idx_min_10], data1$lat[idx_min_10])
points(coord_min, col=rgb(0, 1, 0, 0.5))

coord_both = mapproject(data1$lon[(idx_max_10 & idx_min_10)], data1$lat[(idx_max_10 & idx_min_10)])
points(coord_both, col=rgb(0, 0, 1, 0.5))

# comments
# color = blue i.e. either max and min temperture vary little across the year
# aka, stable weather, hence mostly near the equator.
# color = red i.e. max temperture vary little,
# could be always cold or always hot across the year
# mostly inland, from the result.
# color = green i.e. min temperture vary little,
# warm or cool perhapes

# 2.
data2 = read.delim('2.data.txt', header = TRUE, sep = "\t")
plot(x = data2$mt_max, y = data2$sdt_max)

tmx = data2$mt_max <= quantile(data2$mt_max, na.rm = T, probs = 0.9)
tmx = tmx & (data2$mt_max >= quantile(data2$mt_max, na.rm = T, probs = 0.1))
tmy = data2$sdt_max <= quantile(data2$sdt_max, na.rm = T, probs = 0.9)
tmy = tmy & (data2$sdt_max >= quantile(data2$sdt_max, na.rm = T, probs = 0.1))
qqplot(x = tmx, y = data2$sdt_max)

nonadata2 = na.omit(data2)
cor(nonadata2$mt_max, nonadata2$sdt_max)
# correlation = -0.4
# could be a clue that mean and sd are correlated


# 3.
# all difference
data3_all = read.delim('3_all.data.txt', header = TRUE, sep = "\t")
data3_all = data.frame(station = data3_all$station, diff = data3_all$diff)
data3_all = na.omit(data3_all)

idx_all = data3_all$diff <= quantile(data3_all$diff, probs = 0.99)
idx_all = idx_all & (data3_all$diff >= quantile(data3_all$diff, probs = 0.01))
hist(data3_all$diff[idx_all], freq = F,
     main = 'Histogram of all difference',
     xlab = 'diff',
     sub = 'Some outliers excluded.')

# top and bottom 10%
data3_10 = read.delim('3_10.data.txt', header = TRUE, sep = '\t')

idx_top_10 = data3_10$rnk == 9
idx_bot_10 = data3_10$rnk == 0
map()
coord_top = mapproject(data3_10$lon[idx_top_10], data3_10$lat[idx_top_10])
points(coord_top, col=rgb(1, 0, 0, 0.5))

coord_bot = mapproject(data1$lon[idx_bot_10], data1$lat[idx_bot_10])
points(coord_bot, col=rgb(0, 0, 1, 0.5))

# comments
# land becomes hotter(red points)
# coast becomes cooler(blue points)

