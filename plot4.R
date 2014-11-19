#set the included source dataset folder for your working directory
#read data
library(data.table)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#subset the data to coal_combustion_related_emissions dataset
coal_df <- SCC[which(grepl("Coal",SCC$EI.Sector)),]
#merge two dataset to find matched coal related data.
merge_coal <- merge(PM25,coal_df,by = "SCC")
coal_total <- aggregate(merge_coal$Emissions,by = list(merge_coal$year),sum)
#use ggplot2 to plot it.
png(filename = "plot4.png",width = 500, height = 500)
qplot(coal_total$Group.1,coal_total$x,geom="line",xlab = "Year",ylab = "Emissions(tons)",
      main="coal_combustion_related_emissions")
dev.off()