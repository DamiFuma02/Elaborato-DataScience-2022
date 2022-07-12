

names = c("amazon","disney","gross","movielens","netflix","oscars","sequel","tmdb")
for (i in 1:length(names)){
  source(paste("./R/",names[i],"Data.r",sep=""))
}

genreOcc = function(occType){
  occID = workTable[workTable$workType == occType,]$workID
  mov = left_join(left_join(users %>% filter(Occupation == occID),ratings, by = "userID"),movies,by = "movieID")
  prec = 0
  gen = ""
  for (i in 1:length(genreTable$genre)){
    a = nrow(mov %>% filter(grepl(genreTable$genre[i],Genres)))
    if (a > prec) {
      prec = a
      gen = genreTable$genre[i]
    }
  }
  return(gen)
}
#View(users)


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