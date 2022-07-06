library(readr)
amazon  <- read_csv("../DATASETS/AMAZON/amazon_prime_titles.csv")
spec(amazon)
# View(amazon)


disney <- read_csv("../DATASETS/DISNEY/disney_plus_titles.csv")
spec(disney)
# View(disney)


HighestGrossers <- read_csv("../DATASETS/GROSS/prova.csv")
spec(HighestGrossers)
# View(HighestGrossers)
prova <- read_csv("../DATASETS/GROSS/prova.csv")

movies <- read_delim("../DATASETS/MOVIELENS/ml-1m/movies.dat",delim = ';', col_names = c("movieID","Title","Genres"))
spec(movies)
# View(movies)

ratings <- read_csv("../DATASETS/MOVIELENS/ml-1m/ratings.csv", col_names = c("userID","movieID","Rating","Timestamp"))
spec(ratings)
# View(ratings)
users <- read_csv("../DATASETS/MOVIELENS/ml-1m/users.csv", col_names = c("UserID","Gender","Age","Occupation","Zip"), col_types = "?")
spec(users)
# View(users)

# USA ZIPCODES
uszips <- read_csv("../DATASETS/MOVIELENS/uszips.csv")
spec(uszips)
# View(uszips)




netflix <- read_csv("../DATASETS/NETFLIX/netflix_titles.csv")
spec(netflix)
# View(netflix)




sequels <- read_csv("../DATASETS/SEQUELS/sequels.csv")
# View(sequels)
spec(sequels)


tmdb <- read_csv("../DATASETS/TMDB/tmdb.csv")






