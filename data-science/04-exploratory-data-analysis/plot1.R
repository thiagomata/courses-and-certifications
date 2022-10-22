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
# 7. Plot the Histogram of the Global Active Power (kilowatts)
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
# 7. Plot the Histogram of the Global Active Power (kilowatts)
###

# Create the histogram of the global power active
hist(powerConsumptionData$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main="Global Active Power", 
     col="Red")

###
# 8. Saves the Plot
###

# save into the plot1.png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

###
# 9. Clear the memory
###

# clear the memory
rm( list=ls() )
