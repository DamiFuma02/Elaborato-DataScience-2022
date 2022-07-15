
filePath = "./www/CLEAN_DATA/AMAZON/"
amazon <- read_csv(paste(filePath,"amazon.csv",sep=""),col_types = "ccccicicl")
amazonCountries <- read_csv(paste(filePath,"amazonCountries.csv",sep=""),col_types = "?")
amazonDirectors <- read_csv(paste(filePath,"amazonDirectors.csv",sep=""),col_types = "?")
amazonGenres <- read_csv(paste(filePath,"amazonGenres.csv",sep=""),col_types = "?")
amazonMovies <- read_csv(paste(filePath,"amazonMovies.csv",sep=""),col_types = "?")
amazonRatingTypes <- read_csv(paste(filePath,"amazonRatingTypes.csv",sep=""),col_types = "?")
amazonShows <- read_csv(paste(filePath,"amazonShows.csv",sep=""),col_types = "?")