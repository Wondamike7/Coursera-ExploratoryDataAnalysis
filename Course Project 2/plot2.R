## Read in the data
setInternet2(use=TRUE)
file_name <- "NEI_data.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file_name %in% list.files()) {
	download.file(url,destfile=file_name)
	unzip(file_name)
}

NEI <- readRDS("summarySCC_PM25.rds") ## dim(NEI)  [1] 6497651       6
SCC <- readRDS("Source_Classification_Code.rds") ## dim(SCC)  [1] 11717    15

## Plot 2 - method 1, tapply
plot2sub <- NEI[NEI$fips=="24510",] ## subset to only Baltimore City
plot2data <- tapply(plot2sub$Emissions,plot2sub$year,sum) ## sum all emissions by year for the Balt City subset

png(filename = "plot2.png", 
	height = 480, width = 480,
	units = "px", bg = "white") ## open png for plot2

barplot(plot2data, xlab="Year", main = "Total Emissions in Baltimore City from 1999 to 2008", 
	ylab = expression("Total PM"[2.5]*" Emissions (in tons)"), col="darkblue", ylim=c(0,3500))
## the bars alone don't show a clear trend, so adding a trendline
abline(lm(plot2data ~ c(1, 2, 3, 4)), col = "red", lwd = 4)
## the trendline fits a downward line, so I would say yes, emissions in Baltimore City have decreased

dev.off()	
	
