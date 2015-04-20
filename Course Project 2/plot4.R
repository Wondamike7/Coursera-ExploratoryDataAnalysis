## Read in the data
setInternet2(use=TRUE)
file_name <- "NEI_data.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file_name %in% list.files()) {
	download.file(url,destfile=file_name)
	unzip(file_name)
}

NEI <- readRDS("summarySCC_PM25.rds") ## dim(NEI)  [1] 6497651       	
SCC <- readRDS("Source_Classification_Code.rds") ## dim(SCC)  [1] 11717    15

# identify the SCCs that represent Coal
SCC_Coal <- SCC[grep("Coal",SCC$EI.Sector),] ## Looked for coal in the EI Sector, returns 99 rows, which all appeared to be "combustion-related"
SCC_Coal$SCC <- factor(SCC_Coal$SCC) ## re-factor so only those SCCs for coal are included
Coal_SCCs <- levels(SCC_Coal$SCC)

NEI_Coal <- NEI[NEI$SCC %in% Coal_SCCs,] ## subset the NEI database to only the Coal SCCs
plot4data <- tapply(NEI_Coal$Emissions,NEI_Coal$year,sum) ## sum coal emissions by year

png(filename = "plot4.png", 
	height = 480, width = 480,
	units = "px", bg = "white") ## open png for plot4

barplot(plot4data/10^5, xlab="Year", main = "Total Emissions from Coal\n1999 to 2008", 
	ylab = expression("Total PM"[2.5]*" Emissions (in hundreds of thousands of tons)"), ylim=c(0,6), col="darkblue")

## Emissions from coal have decreased from 1999 to 2008	
	
dev.off()
