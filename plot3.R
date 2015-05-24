if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")

library(ggplot2)

NEI <- readRDS("./data/summarySCC_PM25.rds")
Baltimore <- NEI[NEI$fips=="24510", ]
sumByYearType <- aggregate(Emissions ~ year + type, Baltimore, sum)

png('./exdata-014/plot3.png', width=640, height=480)
g <- ggplot(sumByYearType, aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("Year") + ylab("Total PM2.5 Emissions") + ggtitle("Emissions in Baltimore from 1999 to 2008")
print(g)
dev.off()