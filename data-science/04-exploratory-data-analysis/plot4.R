#####
# Plot a historgram of the global active power of the power consumption 
# into the 02/01/2007 and 02/02/2007
# 
# The data of this assignment is from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets.
#
# In particular, it uses the "Individual household electric power consumption Data Set"
# which was maded available on the course web site.
# 
# 1. Load the necessary libraries
# 2. Download the zip data file
# 3. Extract the data file from the zip
# 4. Read the data from the file
# 5. Convert the date into the data
# 6. Filter the date  of the data into the range 02/01/2007 and 02/02/2007
# 7. Plot the Histogram of the Global Active Power (kilowatts) / Voltage / Global Active Power / Global Rective Power 
# 8. Saves the Plot
# 9. Clear the memory
# 
#####


###
# 1. Load the necessary libraries
###

# clean the memory
rm( list=ls() )

# load library
library(data.table)
Sys.setenv(LANG = "en")
Sys.setlocale("LC_TIME", "en_US")

###
# 2. Download the zip data file ( if necessary )
###

projectPath = "~/Projects/ExData_Plotting1"
powerConsumptionFile = "household_power_consumption.txt"
powerConsumptionUrl  = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Set the local file dir the current path
setwd( projectPath )

# if the data file not exists
if( ! file.exists( powerConsumptionFile ) ) {
  
###
# 3. Extract the data file from the zip
###

  # download the zip file into a temp file
  temp <- tempfile()
  download.file( powerConsumptionUrl, temp )
  
  # unzip the content from the zip file
  unzip( temp, files = powerConsumptionFile )
  
  # remove the zip file
  unlink(temp)
}

###
# 4. Read the data from the file
###

# load the power consumption data
powerConsumptionData <- fread( powerConsumptionFile, na.strings = "?", stringsAsFactors = FALSE)

###
# 5. Convert the date into the data
###

# read the date as d/m/Y
powerConsumptionData[,`:=`( Date = as.Date(Date, format="%d/%m/%Y") ),]

###
# 6. Filter the date  of the data into the range 02/01/2007 and 02/02/2007
###

# filter into the range
powerConsumptionData <- powerConsumptionData[Date >= "2007-02-01" & Date <= "2007-02-02",,]

# read date as posix
powerConsumptionData[,`:=`( Datetime = as.POSIXct(paste(Date, Time)) ),]

###
# 7. Plot the Histogram of the Global Active Power (kilowatts) / Voltage / Global Active Power / Global Rective Power 
###

par(mfrow=c(2,2), mar=c(1,1,1,1), oma=c(0,0,0,0))

plot(Global_active_power ~ Datetime, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="",
     data = powerConsumptionData)
plot(Voltage ~ Datetime, 
     type="l", 
     ylab="Voltage (volt)", 
     xlab="",
     data = powerConsumptionData)
plot(Sub_metering_1 ~ Datetime, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="",
     data = powerConsumptionData)
lines(Sub_metering_2 ~ Datetime,
      col='Red',
      data = powerConsumptionData)
lines(Sub_metering_3 ~ Datetime,
      col='Blue',
      data = powerConsumptionData)
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), 
       lty=1, lwd=2, bty="n")
plot(Global_reactive_power ~ Datetime, 
     type="l", 
     ylab="Global Rective Power (kilowatts)",
     xlab="",
     data = powerConsumptionData)

###
# 8. Saves the Plot
###

# save into the plot1.png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

###
# 9. Clear the memory
###

# clear the memory
rm( list=ls() )
