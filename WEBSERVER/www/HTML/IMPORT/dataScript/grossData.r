filePath = "../../CLEAN_DATA/GROSS/"
gross <- readRDS(paste(filePath,"gross.rds",sep=""))
grossGenres <- readRDS(paste(filePath,"grossGenreTable.rds",sep=""))
grossDistributors = readRDS(paste(filePath,"grossDistributors.rds",sep=""))
grossLicenseTable = readRDS(paste(filePath,"licenseTable.rds",sep=""))
