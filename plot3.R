#set the included source dataset folder for your working directory
#read data
library(data.table)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
Baltimore <- PM25[PM25$fips == "24510",]
#sum the Baltimore emission data in each type of source in given years.
type_baltimore <- aggregate(Baltimore$Emissions,by = list(Baltimore$year, Baltimore$type),sum)
setnames(type_baltimore,c("Group.1","Group.2","x"),c("Year","type","value"))
#use ggplot2 to plot it, every type use different colour
png(filename = "plot3.png",width = 600, height = 500)
ggplot(type_baltimore,aes(x=Year,y=value,colour=type,group=type)) + geom_line()+
  labs(y = "Emissions(tons)",title = "Baltimore_type_emissions")
dev.off()