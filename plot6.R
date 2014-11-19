#set the included source dataset folder for your working directory
#read datalibrary(data.table)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motor_df <- SCC[which(grepl("Vehicles",SCC$EI.Sector)),]
#subset for two cities data
t1 <- rbind(PM25[PM25$fips == c("24510"),],PM25[PM25$fips == c("06037"),])
merge_motor_two_cities <- merge(t1,motor_df,by = "SCC")
motor_total_two_cities <- aggregate(merge_motor_two_cities$Emissions,
                                    by = list(merge_motor_two_cities$year,merge_motor_two_cities$fips),sum)
setnames(motor_total_two_cities,c("Group.1","Group.2","x"),c("Year","City","value"))
png(filename = "plot6.png",width = 1000, height = 500)
#two plot in one panel to show the comperision in two cities.
par(mfcol = c(1,2))
plot(motor_total_two_cities$Year[1:4],motor_total_two_cities$value[1:4],type = "l",xlab = "Year",ylab = "Emissions(tons)"
     ,main = "Los Angeles_motor_vehicle_emissions")
plot(motor_total_two_cities$Year[5:8],motor_total_two_cities$value[5:8],type = "l",xlab = "Year",ylab = "Emissions(tons)"
     ,main = "Baltimore_motor_vehicle_emissions")
dev.off()
