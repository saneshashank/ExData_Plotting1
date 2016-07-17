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

## create png file
png(file="plot1.png")


## create histogram
hist(dfSub$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",ylab = "Frequency" ,main = "Global Active Power")

## close png device.
dev.off()


## remove dfSub from memory
rm(dfSub)
