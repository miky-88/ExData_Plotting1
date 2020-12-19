library(dplyr)

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
# ---------- Save as PNG the histogram of the global active power ---------- #
# -------------------------------------------------------------------------- #

png(filename = "plot1.png", width = 480, height = 480)


hist(dsub$Global_active_power, col = "red"
     , xlab = "Global Active Power (kilowatts)"
     , main = "Global Active Power")

dev.off()
