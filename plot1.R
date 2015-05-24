if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

sumByYear <- aggregate(Emissions ~ year, NEI, sum)

png('./exdata-014/plot1.png')
barplot(height = sumByYear$Emissions, names.arg = sumByYear$year, xlab = "Year", ylab = expression('Total PM2.5 Emission'), main = expression('Total PM2.5 Emissions By Years'))
dev.off()