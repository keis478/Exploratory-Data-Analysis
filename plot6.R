## Download zipfile
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = temp, method = "auto")
unzip(temp)
unlink(temp)

## Read each of the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 6
library(ggplot2)
library(dplyr)

mrg <- inner_join(NEI, SCC, "SCC")
Coal <- mrg[grep("Mobile.*Vehicles", as.character(mrg$EI.Sector)), ]

png("plot6.png", width = 480, height = 480)

sums <- Coal %>%
  subset(fips == "24510" | fips == "06037") %>%
  group_by(year) %>%
  summarise(Total_Emissions = sum(Emissions), na.rm = TRUE)

qplot(year, Total_Emissions,
      data = sums, 
      xlab = "year", 
      ylab = "Emissions (motor vehicle sources)", 
      color = fips,
      geom = "line")
dev.off()