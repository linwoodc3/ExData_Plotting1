# Checks to see if the UCI file is in the local directory; if not downloads and unzips 
if (!file.exists("household_power_consumption.txt")){
        temp <- tempfile()
        download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
        unzip(temp)
}

# Checks the local R library(ies) to see if the required package(s) is/are installed or not. If the 
# package(s) is/are not installed, then the package(s) will be installed along with the required 
# dependency(ies).


# Read in the table
data <- read.table('./household_power_consumption.txt',sep=';',header=TRUE, stringsAsFactors = FALSE)

# Convert date column to date class (reads as a double)
data$Date <- as.Date(strptime(data$Date,"%d/%m/%Y"))

# Subset the data to 02-01-2007 and 02-02-2007
plotdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Convert the time to a time class (reads as a double)
plotdata$Time <- chron(times = plotdata$Time)


# convert all character columns to numeric
# http://stackoverflow.com/questions/22772279/converting-multiple-columns-from-character-to-numeric-format-in-r
plotdata[,3:9] <- (sapply(plotdata[,3:9],as.double))

# Send plot to png file in local directory
png(file = "./plot1.png", width = 480, height = 480,bg = "transparent")

# set outer margins
par(oma=c(0,0,2,0))

# Start the default graphics device; create a histogram
hist(plotdata$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

# Add text to top left corner
mtext("Plot 1",adj=0, outer = TRUE)

# Return plotting device to default
dev.off()
