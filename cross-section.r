# an initial look at the time series from each of the 45 sensors.

# switch the lights out
theme.black <- function() {
  p <- theme_bw()
  p <- p + theme(panel.background=element_rect(fill="#000000"),
                 panel.border=element_rect(size=0),
                 panel.grid.major=element_blank(),
                 panel.grid.minor=element_blank(),
                 axis.ticks=element_line("gray48", size=0.5),
                 plot.background=element_rect(fill="#000000", size=0),
                 text=element_text(colour="#888888"),
                 strip.background=element_rect(fill="#000000", size=0),
                 legend.key=element_rect(fill="#000000", size=0),
                 legend.background=element_rect(fill="#000000", size=0))
  p
}

# plot a single cross section
plot.series <- function(series, title="") {
  library(ggplot2)
  # ggplot does not like x-axis strings. have to work around this.
  labels <- as.character(series$time)
  series$time <- 1:length(labels)
  # every hour
  breaks <- seq(1, length(labels), 12)
  p <- ggplot(data=series, aes(x=time, y=speed))
  p <- p + geom_step(colour="grey")
  p <- p + stat_smooth(method="loess", level=0.9999, se=T, col="#ff0000")
  # put the axis lables back.
  p <- p + scale_x_discrete(breaks=breaks, labels=labels[breaks])
  p <- p + theme(axis.text.x=element_text(angle=90, vjust=0.5))
  p <- p + ggtitle(title)
  p <- p + xlab("time")
  p <- p + ylab("speed")
  p <- p + theme.black()
  p <- p + theme(axis.text.x=element_text(angle=90, vjust=0.5))
  p
}

# save in /tmp
save.to.png <- function(plots, name) {
  print(paste("saving", name))


  ##### WHY DOES EVERYTHING IN GGPLOT NEED TO BE SUCH A MASSIVE PAIN IN THE ASS.
  ##### change the background colour to black? no problem, bg="#000000". I guess
  ##### you would also like to change the foreground colour to white?. maybe fg=
  ##### ? Good luck with that!. Ok, so maybe I should look at the grid.arrange
  ##### docs...
  #Usage:
  #
  #     arrangeGrob(..., as.table = FALSE, clip = TRUE,
  #       main = NULL, sub = NULL, left = NULL, legend = NULL)

  ##### in case you are confused, dont worry:
  # return a frame grob; side-effect (plotting) if plot=T
  

  ## can not figure out how to change foreground colour behind this grid.arrange
  ## arrange thing. wasted enough time trying to figure out ggplot version of
  ## par(mfrow=c(1,2)). note to self: do not waste time with this thing in future.

  png(paste0("/home/phil/athens-traffic/plots/", gsub(" ", "_", name), ".png"), width=1146, height=800, res=120, bg="#999999") 


  do.call(grid.arrange, c(plots, ncol=length(plots), main=name))
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
  
  p1 <- plot.series(data.frame(time=weekday.bin.speeds$time, speed=rowMeans(weekday.bin.speeds[, 2:46])), "week")
  p2 <- plot.series(data.frame(time=saturday.bin.speeds$time, speed=rowMeans(saturday.bin.speeds[, 2:46])), "sat")
  p3 <- plot.series(data.frame(time=sunday.bin.speeds$time, speed=rowMeans(sunday.bin.speeds[, 2:46])), "sun")
  save.to.png(list(p1, p2, p3), "all-speeds")

  for(i in 1:45) {
    title <- paste(as.character(unlist(road.segments[i, 1:4])), collapse="-")
    p1 <- plot.series(data.frame(time=weekday.bin.speeds$time, speed=weekday.bin.speeds[, i+1]), "week")
    p2 <- plot.series(data.frame(time=saturday.bin.speeds$time, speed=saturday.bin.speeds[, i+1]), "sat")
    p3 <- plot.series(data.frame(time=sunday.bin.speeds$time, speed=sunday.bin.speeds[, i+1]), "sun")
    save.to.png(list(p1, p2, p3), title)
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
#bin.speeds <- apply(traffic.data[, 2:46], 2, function(v) rowMeans(matrix(v, nrow=288), na.rm=T))

# as a data.frame with first column as time period (char).
# bins are ordered from first observation at 00:00, through to last at 23:55.
#bin.speeds <- data.frame(time=format(head(traffic.data$timestamp, 288), "%H:%M"), bin.speeds)
#bin.speeds <- bin.speeds[order(bin.speeds$time), ]

bin.speeds <- function(traffic.data) {
  bins <- apply(traffic.data[, 2:46], 2, function(v) rowMeans(matrix(v, nrow=288), na.rm=T))
  bins <- data.frame(time=format(head(traffic.data$timestamp, 288), "%H:%M"), bins)
  bins[order(bins$time), ]
}

weekday.bin.speeds <- bin.speeds(traffic.data[weekdays(traffic.data$timestamp) != "Saturday" & weekdays(traffic.data$timestamp) != "Sunday", ])
saturday.bin.speeds <- bin.speeds(traffic.data[weekdays(traffic.data$timestamp) == "Saturday", ])
sunday.bin.speeds <- bin.speeds(traffic.data[weekdays(traffic.data$timestamp) == "Sunday", ])

}

