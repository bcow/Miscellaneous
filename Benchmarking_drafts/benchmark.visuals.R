data <- obvs[c("RING", "CO2", "BLOCK", "LAI", "YEAR")]
boxplot(data$LAI)


# require(ggplot2)
# p <- ggplot(data, aes(CO2, LAI))
# 
# p + geom_boxplot(aes(fill = factor(BLOCK)))
# 
# p + geom_point(aes(colour = factor(CO2), shape = factor(BLOCK)), size = 4)


YEARS <- sort(unique(data$YEAR))
  
data$YEAR <- as.factor(data$YEAR)
data$BLOCK <- as.factor(data$BLOCK)
data$CO2 <- as.factor(data$CO2)

data$LAI <- as.numeric(data$LAI)

test <- aggregate(LAI ~ YEAR + CO2, dat = data, FUN = "mean")
LAI <- split(test,test$CO2)

plot(as.numeric(as.character(LAI$elev$YEAR)),LAI$elev$LAI, type = "l", lwd = 3, col = "red")
lines(as.numeric(as.character(LAI$amb$YEAR)),LAI$amb$LAI, lwd = 3, col = "green")


