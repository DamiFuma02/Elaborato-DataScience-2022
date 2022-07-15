
filePath = "./www/CLEAN_DATA/NETFLIX/"
netflix <- read_csv(paste(filePath,"netflix.csv",sep=""),col_types = "ccccicicl")
netflixCountries <- read_csv(paste(filePath,"netflixCountries.csv",sep=""),col_types = "?")
netflixGenres <- read_csv(paste(filePath,"netflixGenres.csv",sep=""),col_types = "?")
netflixMovies <- read_csv(paste(filePath,"netflixMovies.csv",sep=""),col_types = "?")
netflixRatingTypes <- read_csv(paste(filePath,"netflixRatingTypes.csv",sep=""),col_types = "?")
netflixShows <- read_csv(paste(filePath,"netflixShows.csv",sep=""),col_types = "?")