if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")

library(ggplot2)

NEI <- readRDS("./data/summarySCC_PM25.rds")
BaltimoreLAOnRoad <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD", ]
sumByYearFips <- aggregate(Emissions ~ year + fips, BaltimoreLAOnRoad, sum)
sumByYearFips$fips[sumByYearFips$fips=="24510"] <- "Baltimore"
sumByYearFips$fips[sumByYearFips$fips=="06037"] <- "LA"

png('./exdata-014/plot6.png', width=1040, height=480)
g <- ggplot(sumByYearFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity") + xlab("Year") + ylab('Total PM2.5 Emissions') + ggtitle('Emissions from motor vehicle (ON-ROAD) Baltimore vs Los Angeles1999-2008')
print(g)
dev.off()