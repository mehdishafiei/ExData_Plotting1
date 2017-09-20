
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
date1=as.Date("2007-02-01")
date2=as.Date("2007-02-02")

# Here we prepare the data:
      #first making the correct formatted date. The as.Date does not work unless we convert Date to a good format with strptime
      # For the first plot we only need the date and Global active power ( of course converted one.) if we have a "?" as.numeric will return NA
      # In the third step we filter to the wanted dates
plot1_dt <- mutate(elpow_data, convDate=as.Date(strptime(Date, format = "%d/%m/%Y")) , safeGolabalActive=as.numeric(as.character(Global_active_power) ) ) %>% 
                         select(convDate, safeGolabalActive)  %>% 
                         filter(convDate>=date1 & convDate<=date2  & !is.na(safeGolabalActive))

#Hint: the easiest way to remove "?" is trying to convert them to a number, 
       # This may make warning: NAs introduced by coercionp
       # if success, it is ok, 
       # if not, it returns NA which we filter them with the filter function

png("plot1.png",width = 480,height=480 ,units="px")


hist(plot1_dt$safeGolabalActive, main = "Global Active Power", xlab = "Global Active Powers", col = "red")


dev.off()


