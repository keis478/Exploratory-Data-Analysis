## Download zipfile
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = temp, method = "auto")
unzip(temp)
unlink(temp)

## Read each of the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 4
library(ggplot2)
library(dplyr)

mrg <- inner_join(NEI, SCC, "SCC")
Coal <- mrg[grep("Coal", as.character(mrg$Short.Name)), ]

png("plot4.png", width = 480, height = 480)

sums <- Coal %>%
  group_by(year) %>%
  summarise(Total_Emissions = sum(Emissions), na.rm = TRUE)

with(sums, plot(Total_Emissions ~ year, 
                xlab = "Year", 
                ylab = "Total Emissions (Coal combustion-realted)"))
with(sums, lines(Total_Emissions ~year))

dev.off()