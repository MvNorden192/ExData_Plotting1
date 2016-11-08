## Plot2
## Clear memory before loading
gc()
rm(list=ls())

## Exploratory Data Analysis Week 1 PA - Plot 2
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
  if (!file.exists("household_power_consumption.zip")) {
    download.file(file_url, "household_power_consumption.zip")
  }
  unzip("household_power_consumption.zip")
}

## Reading table
library(data.table)
library(dtplyr)
library(plyr)
library(dplyr)
hhpc_table2 <- fread("household_power_consumption.txt") ## To get a quick look at the data
object.size(hhpc_table <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")) ## Look at memory required
hhpc_table <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?") ## Load the table
rm(hhpc_table2) ## Clean up memory
hhpc_dt <- data.frame(hhpc_table)

## Change date and time format
hhpc_dt$Date <- as.Date(hhpc_dt$Date, format = "%d/%m/%Y")
hhpc_dt$Time <- strptime(hhpc_dt$Time, format = "%H:%M:%S")
hhpc_dt$Time <- format(hhpc_dt$Time, "%H:%M:%S")

## Keep only the data for dates 2007-02-01 and 2007-02-01
part_a <- subset(hhpc_dt, Date == "2007-02-01")
part_b <- subset(hhpc_dt, Date == "2007-02-02")
data_to_use <- rbind(part_a, part_b)
data_to_use$NewDate <- as.POSIXct(paste(data_to_use$Date, data_to_use$Time))

## Create Plot2
with(data_to_use, plot(Global_active_power ~ NewDate, type = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(data_to_use, lines(Global_active_power ~ NewDate))

## Save Plot2
dev.copy(png, file = "plot2.png")
dev.off()
