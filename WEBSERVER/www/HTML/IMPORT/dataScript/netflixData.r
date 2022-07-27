filePath = "../../CLEAN_DATA/NETFLIX/"
netflix <- readRDS(paste(filePath,"netflix.rds",sep=""))
netflixCountries <- readRDS(paste(filePath,"netflixCountries.rds",sep=""))
netflixGenres <- readRDS(paste(filePath,"netflixGenres.rds",sep=""))
netflixMovies <- readRDS(paste(filePath,"netflixMovies.rds",sep=""))
netflixRatingTypes <- readRDS(paste(filePath,"netflixRatingTypes.rds",sep=""))
netflixShows <- readRDS(paste(filePath,"netflixShows.rds",sep=""))