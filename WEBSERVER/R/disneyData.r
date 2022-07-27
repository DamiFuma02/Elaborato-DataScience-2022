filePath = "./www/CLEAN_DATA/DISNEY/"
disney <- readRDS(paste(filePath,"disney.rds",sep=""))
disneyCountries <- readRDS(paste(filePath,"disneyCountries.rds",sep=""))
disneyGenres <- readRDS(paste(filePath,"disneyGenreTable.rds",sep=""))
disneyMovies <- readRDS(paste(filePath,"disneyMovies.rds",sep=""))
disneyRatingTypes <- readRDS(paste(filePath,"disneyRatingTypes.rds",sep=""))
disneyShows <- readRDS(paste(filePath,"disneyShows.rds",sep=""))