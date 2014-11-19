#set the included source dataset folder for your working directory
#read data
library(data.table)
PM25 <- readRDS("summarySCC_PM25.rds")
#subset the Baltimore emission data
Baltimore <- PM25[PM25$fips == "24510",]
#sum the Baltimore emission data in given year
bal_emissions <- aggregate(Baltimore$Emissions,by=list(Baltimore$year),sum)
setnames(bal_emissions,"Group.1","year")
png(filename = "plot2.png",width = 500, height = 500)
plot(bal_emissions$year,bal_emissions$x,type="l",xlab = "Year",ylab = "Emissions(tons)"
     ,main = "Total_emissions in Baltimore City")
dev.off()