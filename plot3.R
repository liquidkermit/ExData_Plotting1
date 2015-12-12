#download data set into a temp file
temp <- tempfile()
furl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(furl, temp, method = "curl")

#read the data into cp1 dataframe
cp1 <- read.table(unz(temp, "household_power_consumption.txt"), 
                  header = TRUE, sep = ";", na.strings = "?")
unlink(temp)

#We will only be using data from the dates 2007-02-01 and 2007-02-02
cp1 <- subset(cp1, Date == "1/2/2007" | Date == "2/2/2007")

#create a date time variable
cp1$datetime <- paste(cp1$Date, cp1$Time, sep = " ")
cp1$datetime <- strptime(cp1$datetime, "%e/%m/%Y %H:%M:%S")

#Plot 3
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12)
with(cp1, {
    plot(datetime, Sub_metering_1, type = "l", col = "black", ylab ="Energy sub metering")
    lines(datetime, Sub_metering_2, col ="red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty = 1, 
           col = c("black", "red", "blue"))
})
dev.off()
