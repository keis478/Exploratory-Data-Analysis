## Download zipfile
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = temp, method = "auto")
unzip(temp)
unlink(temp)

## Read each of the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 2
if (!require(dplyr)) {
  install.packages("dplyr")
  library(dplyr)
}

Bal <- NEI %>%
  subset(fips == "24510") %>%
  group_by(year) %>%
  summarise(Total_Emissions = sum(Emissions), na.rm = TRUE)

with(Bal, plot(Total_Emissions ~ year, xlab = "year", ylab = "Emissions (Baltimore City)"))
with(Bal, lines(Total_Emissions ~year))

