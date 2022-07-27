filePath = "../../CLEAN_DATA/MOVIELENS/"
movies <- readRDS(paste(filePath, "movies.rds",sep=""))
ratings <- readRDS(paste(filePath, "ratings.rds",sep=""))
users <- readRDS(paste(filePath, "users.rds",sep=""))
workTable <- readRDS(paste(filePath, "workTable.rds",sep=""))
ageTable <- readRDS(paste(filePath, "ageTable.rds",sep=""))
uszips <- readRDS(paste(filePath, "uszips.rds",sep=""))
MLGenres = readRDS(paste(filePath, "movieLensGenreTable.rds",sep=""))