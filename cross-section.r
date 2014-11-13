# an initial look at the time series from each of the 45 sensors.

# plot a single cross section
plot.series <- function(series, title="") {
  library(ggplot2)
  # ggplot does not like x-axis strings. have to work around this.
  labels <- as.character(series$time)
  series$time <- 1:length(labels)
  # every hour
  breaks <- seq(1, length(labels), 12)
  p <- ggplot(data=series, aes(x=time, y=speed))
  p <- p + geom_line()
  # put the axis lables back.
  p <- p + scale_x_discrete(breaks=breaks, labels=labels[breaks])
  p <- p + theme(axis.text.x=element_text(angle=90, vjust=0.5))
  p <- p + ggtitle(title)
  p <- p + xlab("time")
  p <- p + ylab("speed")
  p
}

# save in /tmp
save.to.png <- function(plot, name) {
  print(paste("saving", name))
  png(paste0("/home/phil/athens-traffic/plots/", gsub(" ", "_", name), ".png"), width=700, height=350, res=120)
  print(plot)
  dev.off()
}

# plot all the cross sections and save to /tmp
plot.all <- function() {
  #library(gridExtra)
  #plots <- lapply(1:45, function(i) {
  #  title <- paste(as.character(unlist(road.segments[i, 1:4])), collapse="-")
  #  plot.series(data.frame(time=bin.speeds$time, speed=bin.speeds[, i+1]), title)
  #})
  #do.call(grid.arrange, c(plots, ncol=5))
  
  p <- plot.series(data.frame(time=bin.speeds$time, speed=rowMeans(bin.speeds[, 2:46])), "grand average")
  save.to.png(p, "grand average")

  for(i in 1:45) {
    title <- paste(as.character(unlist(road.segments[i, 1:4])), collapse="-")
    p <- plot.series(data.frame(time=bin.speeds$time, speed=bin.speeds[, i+1]), title)
    save.to.png(p, title)
  }
} 

if(F) {
# cut off last observations so that data can be equally divided into 288 5
# minute bins per day.
traffic.data <- head(traffic.data, round(length(traffic.data$timestamp)/288)*288)

# for each of the 45 time series but the observations into 288 rows of 5 minute
# bins, where each column represents 1 day of observations. then take the mean
# of each bin (for example, the first mean will be the mean of all observations
# for the first 5 minutes of the day). the result is a 288 row * 45 column
# matrix, where each column represents the mean observations for each 5 minute
# period for each of the 45 time series.
bin.speeds <- apply(traffic.data[, 2:46], 2, function(v) rowMeans(matrix(v, nrow=288), na.rm=T))

# as a data.frame with first column as time period (char).
# bins are ordered from first observation at 00:00, through to last at 23:55.
bin.speeds <- data.frame(time=format(head(traffic.data$timestamp, 288), "%H:%M"), bin.speeds)
bin.speeds <- bin.speeds[order(bin.speeds$time), ]
}

