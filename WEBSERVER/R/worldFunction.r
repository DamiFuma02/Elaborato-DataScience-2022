# IMPORT CLEANED DATA
names = c("amazon","disney","gross","movielens","netflix","oscars","sequel")
for (i in 1:length(names)){
  source(paste("./R/",names[i],"Data.r",sep=""))
}

# APP FUNCTIONS


# RECCOMENDATION SYSTEM

importData = function(movieType,platform){
  l = length(platform)
  if (movieType == "M"){   #MOVIE
   if (l==1){
     data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform),"/",platform,"Movies.csv",sep=""))
     return (data %>% select(title,Year,rating,duration))
    } else {
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform[1]),"/",platform[1],"Movies.csv",sep=""))  %>% select(title,Year,rating,duration)
      for (i in 1:(l-1)){
        data = inner_join(data,  read_csv(paste("./www/CLEAN_DATA/",toupper(platform[i+1]),"/",platform[i+1],"Movies.csv",sep=""))  %>% select(title,Year,rating,duration),by="title")
        data = data %>% filter((`Year.x` == `Year.y`) && (`duration.x` == `duration.y`))      %>% mutate(Year = `Year.x`,rating = `rating.x`,duration = `duration.x`) %>% select(title,Year,duration,rating)
      }
      return (data)
    }
  } else if (movieType == "T") {   #TV-SHOW
    if (l==1){
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform),"/",platform,"Shows.csv",sep=""))
      return (data %>% select(title,Year,rating,Seasons))
    } else {
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform[1]),"/",platform[1],"Shows.csv",sep=""))  %>% select(title,Year,rating,Seasons)
      for (i in 1:(l-1)){
        data = inner_join(data,  read_csv(paste("./www/CLEAN_DATA/",toupper(platform[i+1]),"/",platform[i+1],"Shows.csv",sep=""))  %>% select(title,Year,rating,Seasons),by="title")
        data = data %>% filter((`Year.x` == `Year.y`) && (`Seasons.x` == `Seasons.y`))      %>% mutate(Year = `Year.x`,rating = `rating.x`,Seasons = `Seasons.x`) %>% select(title,Year,Seasons,rating)
      }
      return (data)
    }
  } else {  #  BOTH
    if (l==1){
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform),"/",platform,".csv",sep=""))
      return (data %>% select(title,Year,rating,duration))
    } else {
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform[1]),"/",platform[1],".csv",sep=""))  %>% select(title,Year,rating,duration)
      for (i in 1:(l-1)){
        data = inner_join(data,  read_csv(paste("./www/CLEAN_DATA/",toupper(platform[i+1]),"/",platform[i+1],".csv",sep=""))  %>% select(title,Year,rating,duration),by="title")
        data = data %>% filter((`Year.x` == `Year.y`) && (`duration.x` == `duration.y`))      %>% mutate(Year = `Year.x`,rating = `rating.x`,duration = `duration.x`) %>% select(title,Year,duration,rating)
      }
      return (data)
    }
  }
}

reccomendAPP = function(compiledList){
  platform = unlist(compiledList$platform)
  movieType = compiledList$movieType
  chosenArr = compiledList$arrange
  order = compiledList$order
  dataFrame = importData(movieType,platform) %>% select(title,chosenArr)
  if (order == "A"){
    return(head(dataFrame %>% arrange(dataFrame[chosenArr])))
  } else {
    return(head(dataFrame %>% arrange(desc(dataFrame[chosenArr]))))
  }
  
}





# MOVIELENS
genreOcc = function(occType){
  occID = workTable[workTable$workType == occType,]$workID
  mov = left_join(left_join(users %>% filter(Occupation == occID),ratings, by = "userID"),movies,by = "movieID")
  prec = 0
  gen = ""
  for (i in 1:length(MLGenres$genre)){
    a = nrow(mov %>% filter(Rating >= 4) %>% filter(grepl(MLGenres$genre[i],Genres)))
    if (a > prec) {
      prec = a
      gen = MLGenres$genre[i]
    }
  }
  return(gen)
}

userMapByGenre = function(genre){  # STRINGA
  movieGenreID = (movies %>% filter(grepl(genre,Genres)))$movieID
  meanUserRatings = ratings %>% filter(movieID %in% movieGenreID)  %>% group_by(userID) %>% summarise(numOfRatings = n(),MeanRating = mean(Rating))
  head(meanUserRatings)
  
  meanUserRatings = left_join(meanUserRatings,users,by="userID")
  head(meanUserRatings)
  
  
  # aggiungere info geografiche per creare la mappa
  prova = left_join(meanUserRatings,uszips,by="zip") %>% select(MeanRating,zip,lat,lng,county_fips)
  colnames(prova)[5] = "fips"
  head(prova)
  
  plot = plot_usmap(data = prova, values = "MeanRating") +  scale_fill_continuous( low = "red", high = "green", name = "Mean Rating", label = scales::comma ) + theme(legend.position = "right")
  
  return(plot)
  
}