library(dplyr)

Sys.setlocale("LC_ALL", "English")

# -------------------------------------------------------------------------- #
# -------------------------- Load zip file into R -------------------------- #
# -------------------------------------------------------------------------- #
d <- read.table(unzip("./data/exdata_data_household_power_consumption.zip"
                      , exdir = "./data")
                , header = TRUE, sep = ";"
                , na.strings = "?"
)

# -------------------------------------------------------------------------- #
# -------------------- Transform class of Date and Time -------------------- #
# -------------------------------------------------------------------------- #

d$Time <- paste(d$Date, d$Time, sep = " ")

d$Date <- as.Date(d$Date, "%d/%m/%Y")

d$Time <- strptime(d$Time, "%d/%m/%Y %H:%M:%S")

d <- rename(d, Datetime = Time)

# -------------------------------------------------------------------------- #
# ---------------------------- Subset the data ----------------------------- #
# -------------------------------------------------------------------------- #

d <- tibble::as_tibble(d)

dsub <- filter(d, Date >= as.Date("2007-02-01", format = "%Y-%m-%d") 
               & Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))

# -------------------------------------------------------------------------- #
# --------- Save as PNG the time performance of the sub metering ----------- #
# -------------------------------------------------------------------------- #

png(filename = "plot3.png", width = 480, height = 480)

plot(dsub$Datetime, dsub$Sub_metering_1, type = "l", col = "black"
     , xlab = "", ylab = "Energy sub metering")

lines(dsub$Datetime, dsub$Sub_metering_2, type = "l", col = "red")

lines(dsub$Datetime, dsub$Sub_metering_3, type = "l", col = "blue")

legend("topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col = c("black", "red", "blue"), lty = 1)

dev.off()