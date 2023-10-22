#Reading all data and then subsetting it
library(tidyr)
entire_data = read.table("household_power_consumption.txt", sep = ";", header = TRUE)

my_data <- rbind(subset(entire_data, Date == "1/2/2007"), subset(entire_data, Date == "2/2/2007"))

#Creating the png file

png(filename="plot1.png", width = 480, height = 480, units = "px")

#Since the data is of character type, I needed to convert it to numerical
#values and then place all the attributes for copying the plot style

hist(as.numeric(my_data$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()