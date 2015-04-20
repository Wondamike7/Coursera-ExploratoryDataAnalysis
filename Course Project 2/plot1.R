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

## Generate plot 1
plot1data <- tapply(NEI$Emissions,NEI$year,sum) ## sums all Emissions by year

png(filename = "plot1.png", 
	height = 480, width = 480,
	units = "px", bg = "white") ## open a png window for plot1.png
	
barplot(plot1data/10^6, xlab="Year", main = "Total Emissions from 1999 to 2008", 
	ylab = expression("Total PM"[2.5]*" Emissions (in millions of tons)"),
	col = "darkblue")

## Yes, total emissions appear to have decreased over the four years shown	

dev.off()

