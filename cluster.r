library(gplots)

bin.speeds <- function(traffic.data) {
  bins <- apply(traffic.data[, 2:46], 2, function(v) rowMeans(matrix(v, nrow=288), na.rm=T))
  bins <- data.frame(time=format(head(traffic.data$timestamp, 288), "%H:%M"), bins)
  bins[order(bins$time), ]
}

traffic.data <- head(traffic.data, round(length(traffic.data$timestamp)/288)*288)
weekday.bin.speeds <- bin.speeds(traffic.data[weekdays(traffic.data$timestamp) != "Saturday" & weekdays(traffic.data$timestamp) != "Sunday", ])
saturday.bin.speeds <- bin.speeds(traffic.data[weekdays(traffic.data$timestamp) == "Saturday", ])
sunday.bin.speeds <- bin.speeds(traffic.data[weekdays(traffic.data$timestamp) == "Sunday", ])

col.pal <- colorRampPalette(c("#f92b20", "#fe701b", "#facd1f", "#d6fd1c", 
                              "#65fe1b", "#1bfe42", "#1cfdb4", "#1fb9fa", 
                              "#1e71fb", "#261cfd"))(100)

# time labels (every half an hour)
bins <- weekday.bin.speeds$time
time.labels <- ifelse(rep(c(T,F,F,F,F,F), 48), as.character(bins), NA)
road.labels <- paste(sprintf("%02d", 1:45), apply(road.segments[, 1:4], 1, function(x) paste(x, collapse="-")))

png("/tmp/cluster.png", width=1200, height=800, res=120, bg="#000000")

par(bg="black", fg="white", col.lab="white", col.axis="white", col.main="white", col.sub="white")
heatmap.2(t(weekday.bin.speeds[, 2:46]), dendrogram="row", key=T, col=col.pal, trace="none", scale="none", Colv=F, labCol=time.labels, labRow=road.labels, main="hierarchical clustering of avg. speed", xlab="time of day", margins=c(4,18))

dev.off()

