## load dplyr package
library(dplyr)

## load lubridate package
library(lubridate)

## set file path for text file
FilePath <- ".//exdata_data_household_power_consumption//household_power_consumption.txt"

## load the file into data frame
df <- read.table(FilePath,sep=";",header = TRUE,quote = "", stringsAsFactors = FALSE,na.strings = "?")

## convert Date column to date time (using lubridate pckg functions)
df <- mutate(df,Date = dmy(Date))

## take subset of dataframe for dates on 2007-02-01 and 2007-02-02
dfSub <- subset(df,Date=="2007-02-01" | Date=="2007-02-02")

## remove df from memory
rm(df)

## Add DateTime Column in dfSub combining Date and Time columns
dfSub <- mutate(dfSub,DateTime = paste(Date,Time,sep = " ") )

## convert DateTime column to date time using ymd_hms() from lubridate package
dfSub <- mutate(dfSub,DateTime = ymd_hms(DateTime))

## create png file
png(file="plot4.png")


## divide the plot into 2 rows and 2 columns with appropriate margins 
par(mfrow=c(2,2),mar=c(5,4,2,1))

## Add 1st plot: Global Active Power vs days
plot(dfSub$DateTime,dfSub$Global_active_power,type="l", xlab="" ,ylab="Global Active Power")

## Add 2nd plot: Voltage vs days
plot(dfSub$DateTime,dfSub$Voltage,type="l", xlab="datetime" ,ylab="Voltage")

## Add 3rd plot: Energy submetering vs days
plot(dfSub$DateTime,dfSub$Sub_metering_1,type="l", xlab="" ,ylab="Energy sub metering")
lines(dfSub$DateTime,dfSub$Sub_metering_2,col="red")
lines(dfSub$DateTime,dfSub$Sub_metering_3,col="blue")
## Add legend on top right corner
legend("topright",lty=c(1,1,1),lwd=c(1.5,1.5,1.5),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Add 4th plot: Global reactive power vs days
plot(dfSub$DateTime,dfSub$Global_reactive_power,type="l", xlab="datetime" ,ylab="Global_reactive_power")


## close png device.
dev.off()


## remove dfSub from memory
rm(dfSub)
