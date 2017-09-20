
# The following line just downloads the file. The downloading is not part of the rpject
# I cooment it since the Data only needs to be downloaded on time:

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Elec_power_conspn.zip")

# Then unzipping that:
unzip("Elec_power_conspn.zip")



# the next step is to loading the file, which is asked in the project:
# subsetting before reading is difficult, and the file is not big, so I just skip for time being

elpow_data <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)

# now subsetting data:

#  I rather to subset with dplyr package (from the 3rc corse of the specialization), so I need to load this package:

library(dplyr)

# we need to filter only desired dates:
date1=as.POSIXct(paste("2007-02-01", "0:0:0"), format="%Y-%m-%d %H:%M:%S")
date2=as.POSIXct(paste("2007-02-02", "23:59:59"), format="%Y-%m-%d %H:%M:%S")

# Here we prepare the data:
      #first making the correct formatted date. 
      # We mix date and time with the PSIXCt format:
plot2_dt <- mutate(elpow_data, convDateTime=as.POSIXct(paste(as.character(Date),as.character(Time)), format="%d/%m/%Y %H:%M:%S") ,
                              safeGolabalActive=as.numeric(as.character(Global_active_power) ) ) %>% 
                         select(convDateTime, safeGolabalActive)  %>% 
                         filter(convDateTime>=date1 & convDateTime<=date2  & !is.na(safeGolabalActive))

#Hint: the easiest way to remove "?" is trying to convert them to a number, 
       # This may make warning: NAs introduced by coercionp
       # if success, it is ok, 
       # if not, it returns NA which we filter them with the filter function

# maybe we want to check Na with: ( sine the hist plot does not have it)
#table(is.na(plot1_dt$safeGolabalActive))


png("plot2.png",width = 480,height=480 ,units="px")

with( plot2_dt, plot(convDateTime, safeGolabalActive, type = "l",ylab = "Global Active Powers", xlab = ""))


dev.off()


