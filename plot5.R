#set the included source dataset folder for your working directory
#read data
library(data.table)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the dataset to motor_vehicles_emssions data.
motor_df <- SCC[which(grepl("Vehicles",SCC$EI.Sector)),]
#merge two dataset to find matched motor_vehicles_emssions in Baltimore City.
merge_motor <- merge(PM25[PM25$fips == "24510",],motor_df,by = "SCC")
motor_total <- aggregate(merge_motor$Emissions,by = list(merge_motor$year),sum)
png(filename = "plot5.png",width = 500, height = 500)
qplot(motor_total$Group.1,motor_total$x,geom="line",xlab = "Year",ylab = "Emissions(tons)",
      main="Baltimore_motor_vehicle_emissions")
dev.off()