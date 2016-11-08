## Plot3
## Clear memory before loading
gc()
rm(list=ls())

## Exploratory Data Analysis Week 1 PA - Plot 3
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

## Create Plot4 - Setting device
plot_number <- 3
png(filename = paste("plot",plot_number,".png", sep = ""), width = 480, height = 480, units = "px")

## Create Plot3
plot.new()
with(data_to_use, plot(Sub_metering_1 ~ NewDate, col = "black", type = "n", xlab = "",ylab = "Energy sub metering"))
lines(data_to_use$Sub_metering_1 ~ data_to_use$NewDate, col = "black")
lines(data_to_use$Sub_metering_2 ~ data_to_use$NewDate, col = "red")
lines(data_to_use$Sub_metering_3 ~ data_to_use$NewDate, col = "blue")
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 2, lty = 1)

## Save Plot3
#dev.copy(png, file = "plot3.png")
dev.off()
