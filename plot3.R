
## Set locale to show English days instead of Dutch days
Sys.setlocale("LC_TIME","C")

## read in the raw file, ensure it is in the working directory!
hpc <- read.table("household_power_consumption.txt", 
                  sep=";", 
                  header=TRUE, 
                  stringsAsFactors=FALSE, 
                  dec=".", 
                  na.strings="?",
                  colClasses=c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

## combine date and time fields into POSIX format
hpc$DateTime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")

## subset the data to the 2 mentioned days
hpc <- subset(hpc, DateTime >= "2007/02/01 00:00:00" & DateTime <= "2007/02/02 23:59:59")

png("plot3.png", width=480, height=480)
with(hpc, plot(DateTime, Sub_metering_1, type='n', xlab="", ylab="Energy sub metering"))
lines(hpc$DateTime, hpc$Sub_metering_1)
lines(hpc$DateTime, hpc$Sub_metering_2, col="red")
lines(hpc$DateTime, hpc$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
dev.off()

