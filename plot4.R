
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

      plot4_dt <- mutate(elpow_data, convDateTime=as.POSIXct(paste(as.character(Date),as.character(Time)), format="%d/%m/%Y %H:%M:%S") ,
                              safeGolabalActive=as.numeric(as.character(Global_active_power)),
                              safeVoltage=as.numeric(as.character(Voltage) ),
                              safeSub_metering_1=as.numeric(as.character(Sub_metering_1)),
                              safeSub_metering_2=as.numeric(as.character(Sub_metering_2)),
                              safeSub_metering_3=as.numeric(as.character(Sub_metering_3)),
                              safeGolabalreActive=as.numeric(as.character(Global_reactive_power))
                         ) %>%
                         select(convDateTime,
                                safeGolabalActive,
                                safeVoltage,
                                safeSub_metering_1,
                                safeSub_metering_2,
                                safeSub_metering_3,
                                safeGolabalreActive)  %>%
                         filter(convDateTime>=date1 & convDateTime<=date2 )

   #Hint: the easiest way to remove "?" is trying to convert them to a number, 
   # This may make warning: NAs introduced by coercionp
       # if success, it is ok, 
       # if not, it returns NA which we filter them with the filter function

# maybe we want to check Na with: ( sine the hist plot does not have it)
#table(is.na(plot1_dt$safeGolabalActive))


# now plotting all 4 figure in one plot:

png("plot4.png",width = 480,height=480 ,units="px")

# we need 2 rows nad 2 columns
par(mfrow=c(2,2))

# plot 1 is like plot 2 of the project:


with( plot4_dt, plot(convDateTime, safeGolabalActive, type = "l",ylab = "Global Active Powers", xlab = ""))
# Hint: NAs are neglected in the plot function.

# plot 2 is like plot 1 but with Voltage 

with( plot4_dt, plot(convDateTime, safeVoltage, type = "l",ylab = "Voltage", xlab = "datetime"))

# plot 3 is like plot 3 of the project:

with( plot4_dt, plot(convDateTime, safeSub_metering_1,  type = "l",ylab = "Energy sub metering", xlab = ""))
with( plot4_dt, lines(convDateTime,safeSub_metering_2, col="red"))
with( plot4_dt, lines(convDateTime,safeSub_metering_3, col="blue"))

legend("topright", legend=c("safeSub_metering_1", "safeSub_metering_2","safeSub_metering_3"),
       col=c("black", "red","blue"), lwd = 1, box.col = "white", bg="transparent", border = "white", cex=0.9)


with( plot4_dt, plot(convDateTime, safeGolabalreActive , type = "l",ylab = "Golabal_reActive_power", xlab = "datetime"))

dev.off()


