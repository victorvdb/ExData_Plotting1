
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


png("plot1.png", width=480, height=480, units="px")
hist(hpc$Global_active_power, 
        col="red", 
        main="Global Active Power",
        xlab="Global Active Power (kilowatts)",
        ylab="Frequency")
dev.off()


