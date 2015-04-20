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

## Plot 6
## check for ggplot2 package, if not found, install it
if(!require(ggplot2)) {
	install.packages("ggplot2")
	} else {library(ggplot2)}

SCC_Onroad <- SCC[SCC$Data.Category=="Onroad",] ## used only on-road sources, which appeared to capture all motor vehicles of interest
SCC_Onroad$SCC <- factor(SCC_Onroad$SCC) ## re-factored to only motor vehicle SCCs
Onroad_SCCs <- levels(SCC_Onroad$SCC)
NEI_Onroad <- NEI[NEI$SCC %in% Onroad_SCCs,] ## subset to motor vehicle SCCs

plot6sub <- NEI_Onroad[NEI_Onroad$fips=="24510" | NEI_Onroad$fips=="06037",] ## subset to Baltimore City and Los Angeles County
plot6sub$city <- "" ## Add a city column for better labeling in the ggplot graph
plot6sub[plot6sub$fips=="06037",]$city <- "Los Angeles County" ## correct the city entries 
plot6sub[plot6sub$fips=="24510",]$city <- "Baltimore City" ## correct the city entries

png(filename = "plot6.png", 
	height = 480, width = 480,
	units = "px", bg = "white") ## open png for plot6

g6 <- ggplot(plot6sub,aes(factor(year),Emissions, fill=city)) + ## different colors for the two cities
	geom_bar(stat="identity") + 
	facet_grid(.~city) + ## panels by city
	guides(fill=FALSE) + ## don't need the legend, the panels are labeled
	xlab("Year") + 
	ylab(expression("Total PM"[2.5]*" Emissions")) +
	ggtitle("Total Motor Vehicle Emissions in Baltimore City and Los Angeles County\n1999 to 2008")
print(g6)

## LA County has much higher emissions, which have changed more than Baltimore City over time, on an absolute basis

dev.off()
