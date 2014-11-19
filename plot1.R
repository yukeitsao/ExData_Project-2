#set the included source dataset folder for your working directory
#read data
library(data.table)
PM25 <- readRDS("summarySCC_PM25.rds")
#sum the emissions in given years
year_emission <- aggregate(PM25$Emissions,by=list(PM25$year),sum)
setnames(year_emission,"Group.1","year")
#use base ploting system to plot
png(filename = "plot1.png",width = 500, height = 500)
plot(year_emission$year,year_emission$x,type="l",xlab = "Year",ylab = "Emissions(tons)",
     main = "PM2.5_total_emssions in 1999-2008")
dev.off()