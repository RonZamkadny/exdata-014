if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")

library(ggplot2)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
mergedNEISCC <- merge(NEI, SCC, by="SCC")
coal <- grepl("coal", mergedNEISCC$Short.Name, ignore.case=TRUE)
coalNEISCC <- mergedNEISCC[coal, ]

sumByYear <- aggregate(Emissions ~ year, coalNEISCC, sum)

png('./exdata-014/plot4.png', width=640, height=480)
g <- ggplot(sumByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("Year") +  ylab('Total PM2.5 Emissions') + ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()