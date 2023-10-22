#Reading all data and then sub-setting it
library(tidyr)
entire_data = read.table("household_power_consumption.txt", sep = ";", header = TRUE)
my_data <- rbind(subset(entire_data, Date == "1/2/2007"), subset(entire_data, Date == "2/2/2007"))

plot_data = subset(my_data, select = c(Date, Time, Sub_metering_1
                                       ,Sub_metering_2, Sub_metering_3)) %>%
  unite(time, c(Date, Time), sep = " ", remove = TRUE)

plot_data$time = strptime(plot_data$time, format = "%d/%m/%Y %H:%M:%S", tz ="")

#Creating the png file

png(filename="plot3.png", width = 480, height = 480, units = "px")

p <- plot(plot_data$time, plot_data$Sub_metering_1, type ='l', 
          col = "black",
          xaxt = "n",
          xlab = " ", ylab = "Energy sub metering")
lines(plot_data$time,as.numeric(plot_data$Sub_metering_2), type = "l", col = "red", lwd = 1, lty=1)
lines(plot_data$time,as.numeric(plot_data$Sub_metering_3), type = "l", col = "blue", lwd = 1, lty=1)
axis(1, at = pretty(plot_data$time), label = c("Thu", NA, "Fri", NA, "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = c(1,1,1), bg = "transparent")

print(p)
dev.off()