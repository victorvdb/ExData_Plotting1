
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

png("plot4.png", width=480, height=480)
## set 4 plots in window
par(mfrow=c(2,2))

## Plot 1 - top left, Global Active Power over time
with(hpc, plot(DateTime, Global_active_power, type='n', xlab="", ylab="Global Active Power"))
lines(hpc$DateTime, hpc$Global_active_power)

## Plot 2 - top right, voltage over time
with(hpc, plot(DateTime, Voltage, type='n', xlab="datetime", ylab="Voltage"))
lines(hpc$DateTime, hpc$Voltage)

## Plot 3 - bottom left, submetering
with(hpc, plot(DateTime, Sub_metering_1, type='n', xlab="", ylab="Energy sub metering"))
lines(hpc$DateTime, hpc$Sub_metering_1)
lines(hpc$DateTime, hpc$Sub_metering_2, col="red")
lines(hpc$DateTime, hpc$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), bty='n')

## Plot 4 - bottom right, Global reactive power over time
with(hpc, plot(DateTime, Global_reactive_power, type='n', xlab="datetime", ylab="Global_reactive_power"))
lines(hpc$DateTime, hpc$Global_reactive_power)
dev.off()

