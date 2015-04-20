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

## check for ggplot2 package, if not found, install it
if(!require(ggplot2)) {
	install.packages("ggplot2")
	} else {library(ggplot2)}
	
plot3sub <- NEI[NEI$fips=="24510",] ## subset to Baltimore City

png(filename = "plot3.png", 
	height = 480, width = 480,
	units = "px", bg = "white") ## open png for plot3

## Letting ggplot do the sum of emissions by year and type internally
g3 <- ggplot(plot3sub, aes(factor(year), Emissions,fill=type)) + 
	geom_bar(stat="identity") + facet_grid(.~type) + ## add barplot, panels for types
	xlab("Year") + 
	ylab(expression("Total PM"[2.5]*" Emissions (in tons)")) +
	ggtitle("Total Emissions in Baltimore City\nby Type of Emission\n1999 to 2008") +
	guides(fill=FALSE) + ## dropped the type legend, it's clear from the facet labels
	theme(axis.text.x = element_text(size=8)) ## the years weren't showing clearly, so reduced the font size
print(g3) ## need to remember to actually print the plot to the window

## All except "Point" have decreased. "Point" increased from 1999 to 2005 but has dropped back to about 1999 levels.

dev.off()
