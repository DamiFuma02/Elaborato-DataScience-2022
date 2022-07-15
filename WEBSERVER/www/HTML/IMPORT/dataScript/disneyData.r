library(readr)
filePath = "../../CLEAN_DATA/DISNEY/"
disney <- read_csv(paste(filePath,"disney.csv",sep=""),col_types = "ccccicicl")
disneyCountries <- read_csv(paste(filePath,"disneyCountries.csv",sep=""),col_types = "?")
disneyGenres <- read_csv(paste(filePath,"disneyGenres.csv",sep=""),col_types = "?")
disneyMovies <- read_csv(paste(filePath,"disneyMovies.csv",sep=""),col_types = "?")
disneyRatingTypes <- read_csv(paste(filePath,"disneyRatingTypes.csv",sep=""),col_types = "?")
disneyShows <- read_csv(paste(filePath,"disneyShows.csv",sep=""),col_types = "?")