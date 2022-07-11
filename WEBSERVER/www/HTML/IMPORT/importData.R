library(readr)

amazon  <- read_csv("../../DATASETS/AMAZON/amazon_prime_titles.csv")


disney <- read_csv("../../DATASETS/DISNEY/disney_plus_titles.csv")


HighestGrossers <- read_csv("../../DATASETS/GROSS/HighestGrossers.csv")


movies <- read_delim("../../DATASETS/MOVIELENS/ml-1m/movies.dat",delim = ';', col_names = c("movieID","Title","Genres"))

ratings <- read_csv("../../DATASETS/MOVIELENS/ml-1m/ratings.csv", col_names = c("userID","movieID","Rating","Timestamp"))

users <- read_csv("../../DATASETS/MOVIELENS/ml-1m/users.csv", col_names = c("UserID","Gender","Age","Occupation","Zip"), col_types = "?")
# USA ZIPCODES
uszips <- read_csv("../../DATASETS/MOVIELENS/uszips.csv")



netflix <- read_csv("../../DATASETS/NETFLIX/netflix_titles.csv")


oscars <- read_csv("../../DATASETS/OSCARS/oscars.csv")


sequels <- read_delim("../../DATASETS/SEQUELS/sequels.csv",delim = ";")


tmdb <- read_csv("../../DATASETS/TMDB/tmdb.csv")






