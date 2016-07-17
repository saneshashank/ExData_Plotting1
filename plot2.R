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
png(file="plot2.png")


## create plot
## set type = l as the default is a scatterplot
plot(dfSub$DateTime,dfSub$Global_active_power,type="l", xlab="" ,ylab="Global Active Power (kilowatts)")


## close png device.
dev.off()


## remove dfSub from memory
rm(dfSub)
