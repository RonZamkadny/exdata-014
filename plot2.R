if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/FNEI_data.zip")
unzip("./data/FNEI_data.zip", exdir = "./data")

NEI <- readRDS("./data/summarySCC_PM25.rds")
Baltimore <- NEI[NEI$fips=="24510", ]
sumByYear <- aggregate(Emissions ~ year, Baltimore, sum)

png('./exdata-014/plot2.png')
barplot(height = sumByYear$Emissions, names.arg = sumByYear$year, xlab = "Year", ylab = "Baltimore PM2.5 Emission", main = "Baltimore PM2.5 Emissions By Years")
dev.off()