library(readr)
filePath = "./www/CLEAN_DATA/MOVIELENS/"
movies <- read_csv(paste(filePath, "movies.csv",sep=""),col_types = "?")
ratings <- read_csv(paste(filePath, "ratings.csv",sep=""),col_types = "?")
users <- read_csv(paste(filePath, "users.csv",sep=""),col_types = "?")
workTable <- read_csv(paste(filePath, "workTable.csv",sep=""),col_types = "?")
ageTable <- read_csv(paste(filePath, "ageTable.csv",sep=""),col_types = "?")
uszips <- read_csv(paste(filePath, "uszips.csv",sep=""),col_types = "?")
MLGenres = read_csv(paste(filePath, "movieLensGenreTable.csv",sep=""),col_types = "?")