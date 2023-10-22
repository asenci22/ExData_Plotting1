#Reading all data and then sub-setting it
library(tidyr)
entire_data = read.table("household_power_consumption.txt", sep = ";", header = TRUE)
my_data <- rbind(subset(entire_data, Date == "1/2/2007"), subset(entire_data, Date == "2/2/2007"))

plot_data = subset(my_data, select = Date:Global_active_power) %>%
  unite(time, c(Date, Time), sep = " ", remove = TRUE)

plot_data$time = strptime(plot_data$time, format = "%d/%m/%Y %H:%M:%S", tz ="")


#Creating the png file

#png(filename="plot2.png", width = 480, height = 480, units = "px")

png("plot2.png", width = 480, height = 480, units ="px")

p <- plot(plot_data$time, plot_data$Global_active_power, type ='l', xaxt = "n",
          xlab = " ", ylab = "Global Active Power (kilowatts)")
axis(1, at = pretty(plot_data$time), label = c("Thu", NA, "Fri", NA, "Sat"))

print(p)
dev.off()