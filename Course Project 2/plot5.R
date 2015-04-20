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

## Plot 5
SCC_Onroad <- SCC[SCC$Data.Category=="Onroad",] ## used only on-road sources, which appeared to capture all motor vehicles of interest
SCC_Onroad$SCC <- factor(SCC_Onroad$SCC) ## re-factored to only motor vehicle SCCs
Onroad_SCCs <- levels(SCC_Onroad$SCC)
NEI_Onroad <- NEI[NEI$SCC %in% Onroad_SCCs,] ## subset to the appropriate SCCs
plot5sub <- NEI_Onroad[NEI_Onroad$fips=="24510",] ## subset to Baltimore City only
plot5data <- tapply(plot5sub$Emissions,plot5sub$year,sum) ## sum emissions by year

png(filename = "plot5.png", 
	height = 480, width = 480,
	units = "px", bg = "white") ## open png for plot5

barplot(plot5data, xlab="Year", main = "Total Emissions from Motor Vehicle Sources\n1999 to 2008",
	ylab = expression("Total PM"[2.5]*" Emissions (in tons)"),
	col = "darkblue", ylim=c(0,400)) ## changed y-axis limit b/c it was stopping at 300
	
## Motor vehicle emissions, per the definition I used, have dropped in Baltimore City

dev.off()

