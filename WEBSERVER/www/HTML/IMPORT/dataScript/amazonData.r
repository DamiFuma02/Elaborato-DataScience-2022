filePath = "../../CLEAN_DATA/AMAZON/"
amazon <- readRDS(paste(filePath,"amazon.rds",sep=""))
amazonCountries <- readRDS(paste(filePath,"amazonCountries.rds",sep=""))
amazonDirectors <- readRDS(paste(filePath,"amazonDirectors.rds",sep=""))
amazonGenres <- readRDS(paste(filePath,"amazonGenres.rds",sep=""))
amazonMovies <- readRDS(paste(filePath,"amazonMovies.rds",sep=""))
amazonRatingTypes <- readRDS(paste(filePath,"amazonRatingTypes.rds",sep=""))
amazonShows <- readRDS(paste(filePath,"amazonShows.rds",sep=""))