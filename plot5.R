if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")

library(ggplot2)

NEI <- readRDS("./data/summarySCC_PM25.rds")
BaltimoreOnRoad <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD", ]
sumByYear <- aggregate(Emissions ~ year, BaltimoreOnRoad, sum)

png('./exdata-014/plot5.png', width=840, height=480)
g <- ggplot(sumByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("Year") + ylab('Total PM2.5 Emissions') + ggtitle('Emissions from motor vehicle (ON-ROAD) in Baltimore from 1999 to 2008')
print(g)
dev.off()