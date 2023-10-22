#Reading all data and then sub-setting it
library(tidyr)
entire_data = read.table("household_power_consumption.txt", sep = ";", header = TRUE)
my_data <- rbind(subset(entire_data, Date == "1/2/2007"), subset(entire_data, Date == "2/2/2007"))

united_data <- my_data %>% unite(time, Date:Time, sep = " ", remove = TRUE)
united_data$time = strptime(united_data$time, format = "%d/%m/%Y %H:%M:%S", tz ="")


png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfcol=c(2,2))

p1 <- plot(united_data$time, united_data$Global_active_power, type ='l', xaxt = "n",
           xlab = " ", ylab = "Global Active Power (kilowatts)")
axis(1, at = pretty(united_data$time), label = c("Thu", NA, "Fri", NA, "Sat"))
print(p1)

p2 <- plot(united_data$time, united_data$Sub_metering_1, type ='l', 
     col = "black",
     xaxt = "n",
     xlab = " ", ylab = "Energy sub metering")
lines(united_data$time,as.numeric(united_data$Sub_metering_2), type = "l", col = "red", lwd = 1, lty=1)
lines(united_data$time,as.numeric(united_data$Sub_metering_3), type = "l", col = "blue", lwd = 1, lty=1)
axis(1, at = pretty(united_data$time), label = c("Thu", NA, "Fri", NA, "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = c(1,1,1), bg = "transparent")
print(p2)

p3 <- plot(united_data$time, united_data$Voltage, type ='l', 
     col = "black",
     xaxt = "n",
     xlab = "datetime", ylab = "Voltage")
axis(1, at = pretty(united_data$time), label = c("Thu", NA, "Fri", NA, "Sat"))
print(p3)

p4 <- plot(united_data$time, united_data$Global_reactive_power, type ='l', 
     col = "black",
     xaxt = "n",
     xlab = "datetime", ylab = "Global_reactive_power")
axis(1, at = pretty(united_data$time), label = c("Thu", NA, "Fri", NA, "Sat"))
print(p4)
dev.off()