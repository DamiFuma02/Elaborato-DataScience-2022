# IMPORT CLEANED DATA
names = c("amazon","disney","gross","movielens","netflix","oscars","sequel")
for (i in 1:length(names)){
  source(paste("./R/",names[i],"Data.r",sep=""))
}
# APP FUNCTIONS


# RECCOMENDATION SYSTEM

importData = function(movieType,platform){
  l = length(platform)
  if ( "none" %in% platform){
    data = read_csv("./www/CLEAN_DATA/GROSS/gross.csv") %>% select(-license,-distributor)
    colnames(data)[5] = "duration"
    return (data)
  } else if (movieType == "M"){   #MOVIE
   if (l==1){
     data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform),"/",platform,"Movies.csv",sep=""))
     return (data %>% select(title,year,rating,duration))
    } else {
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform[1]),"/",platform[1],"Movies.csv",sep=""))  %>% select(title,year,duration)
      for (i in 1:(l-1)){
        data = inner_join(data,  read_csv(paste("./www/CLEAN_DATA/",toupper(platform[i+1]),"/",platform[i+1],"Movies.csv",sep=""))  %>% select(title,year,duration),by="title")
        test = data %>% filter((`year.x` == `year.y`) && (`duration.x` == `duration.y`))      %>% mutate(year = `year.x` ,duration = `duration.x`) %>% select(title,year,duration )
        if( nrow(test) == 0){
          return (NULL)
        } else {
          data = test
        }
      }
      
      inner_join(data,gross,)
      return (data)
    }
  } else if (movieType == "T") {   #TV-SHOW
    if (l==1){
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform),"/",platform,"Shows.csv",sep=""))
      return (data %>% select(title,year,seasons))
    } else {
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform[1]),"/",platform[1],"Shows.csv",sep=""))  %>% select(title,year,seasons)
      for (i in 1:(l-1)){
        data = inner_join(data,  read_csv(paste("./www/CLEAN_DATA/",toupper(platform[i+1]),"/",platform[i+1],"Shows.csv",sep=""))  %>% select(title,year ,seasons),by="title")
        test = data %>% filter((`year.x` == `year.y`) && (`seasons.x` == `seasons.y`))      %>% mutate(year = `year.x` ,seasons = `seasons.x`) %>% select(title,year,seasons )
        if( nrow(test) == 0){
          return (NULL)
        } else {
          data = test
        }
      }
      return (data)
    }
  } else {  #  BOTH
    if (l==1){
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform),"/",platform,".csv",sep=""))
      return (data %>% select(title,year, duration))
    } else {
      data = read_csv(paste("./www/CLEAN_DATA/",toupper(platform[1]),"/",platform[1],".csv",sep=""))  %>% select(title,year ,duration)
      for (i in 1:(l-1)){
        data = inner_join(data,  read_csv(paste("./www/CLEAN_DATA/",toupper(platform[i+1]),"/",platform[i+1],".csv",sep=""))  %>% select(title,year,duration),by="title")
        test = data %>% filter((`year.x` == `year.y`) && (`duration.x` == `duration.y`)) %>% mutate(year = `year.x`,duration = `duration.x`) %>% select(title,year,duration)
       if( nrow(test) == 0){
         return (NULL)
       } else {
         data = test
       }
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
  dataFrame = importData(movieType,platform) 
  if (is.null(dataFrame)){
    errorData = data.frame(
      id = -1,
      error = "NOT FOUND"
    )
    return (errorData)
  }
  # MOVIELENS RATING
  
  
   test = inner_join(movies,dataFrame,by="title") %>% filter(`year.x` == `year.y`)  %>% mutate(year = `year.y`) %>% select(-`year.x`,-`year.y`,-movieid)
   if (nrow(test) == 0){
      errorData = data.frame(
        id = -1,
        error = "NOT FOUND"
      )
      return (errorData)
    }
   dataFrame = test
   
  if( (platform != "none") && (movieType == "T") && (chosenArr == "duration")){
    chosenArr = "seasons"
  }
  
  
  # OSCARS
   colnames(oscars)[6] = "title"
   bestOscars = oscars %>% group_by(title) %>% summarise(nominees = n(),year_film = year_film) %>% arrange(desc(nominees))
   dataFrame = left_join(dataFrame,bestOscars,by="title")
  
  
  if (order == "A"){
   return(head(dataFrame %>% arrange(dataFrame[chosenArr])  ))
  } else {
   return(head(dataFrame %>% arrange(desc(dataFrame[chosenArr]) )    ))
  }
  
}





# MOVIELENS
genreOcc = function(occType){
  occID = workTable[workTable$workType == occType,]$workID
  userRatings = left_join(left_join(users %>% filter(occupation == occID),ratings, by = "userid"),movies,by = "movieid")
  prec = 0
  gen = ""
  for (i in 1:length(MLGenres$genre)){
    a = nrow(userRatings %>% filter(rating >= 4) %>% filter(grepl(MLGenres$genre[i],genres)))
    if (a > prec) {
      prec = a
      gen = MLGenres$genre[i]
    }
  }
  return(gen)
}

userMapByGenre = function(genre){  # STRINGA
  movieGenreID = (movies %>% filter(grepl(genre,genres)))$movieid
  meanUserRatings = ratings %>% filter(movieid %in% movieGenreID)  %>% group_by(userid) %>% summarise(numOfRatings = n(),MeanRating = mean(rating))
  head(meanUserRatings)
  
  meanUserRatings = left_join(meanUserRatings,users,by="userid")
  head(meanUserRatings)
  
  
  # aggiungere info geografiche per creare la mappa
  prova = left_join(meanUserRatings,uszips,by="zip") %>% select(MeanRating,zip,lat,lng,county_fips)
  colnames(prova)[5] = "fips"
  head(prova)
  
  plot = plot_usmap(data = prova, values = "MeanRating") +  scale_fill_continuous( low = "red", high = "green", name = "Mean Rating", label = scales::comma ) + theme(legend.position = "right")
  
  return(plot)
  
}