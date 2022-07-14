library(readr)

amazon  <- read_csv("../../DATASETS/AMAZON/amazon.csv")


disney <- read_csv("../../DATASETS/DISNEY/disney.csv")


HighestGrossers <- read_csv("../../DATASETS/GROSS/HighestGrossers.csv")


movies <- read_delim("../../DATASETS/MOVIELENS/movies.dat",delim = ';', col_names = c("movieID","Title","Genres"))

ratings <- read_csv("../../DATASETS/MOVIELENS/ratings.csv", col_names = c("userID","movieID","Rating","Timestamp"))

users <- read_csv("../../DATASETS/MOVIELENS/users.csv", col_names = c("UserID","Gender","Age","Occupation","Zip"), col_types = "?")
# USA ZIPCODES
uszips <- read_csv("../../DATASETS/MOVIELENS/uszips.csv")



netflix <- read_csv("../../DATASETS/NETFLIX/netflix.csv")


awards <- read_delim("../../DATASETS/OSCARS/oscars.csv",delim=";")


sequels <- read_delim("../../DATASETS/SEQUELS/sequels.csv",delim = ";")








