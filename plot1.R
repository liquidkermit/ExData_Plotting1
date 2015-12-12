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

#plot 1
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12)
hist(cp1$Global_active_power, 
     col = "red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
