
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
  if( !("none" %in% platform ) && (movieType == "T") && (chosenArr == "duration")){
    chosenArr = "seasons"
  }
  
  # OSCARS
  colnames(oscars)[6] = "title"
  bestOscars = oscars %>% group_by(title) %>% summarise(oscarNominees = n())  
  dataFrame = left_join(dataFrame,bestOscars,by="title") %>% select(title,year,ifelse(("none" %in% platform ),"duration",ifelse((movieType == "T"),"seasons","duration")),oscarNominees)
  
  
  # if (movieType == "T") {
  #   chosenArr = ifelse((chosenArr=="duration"),"seasons",chosenArr)
  #   if (order == "A"){
  #     return(head(dataFrame %>% arrange(dataFrame[chosenArr])  ))
  #   } else {
  #     return(head(dataFrame %>% arrange(desc(dataFrame[chosenArr]) )    ))
  #   }
  # }
  
  # MOVIELENS RATING
   test = inner_join(movies,dataFrame,by="title") %>% filter(`year.x` == `year.y`)  %>% mutate(year = `year.y`) %>% select(-`year.x`,-`year.y`,-movieid)
   if (nrow(test) != 0){
     dataFrame = test
   } 
   
   if (order == "A"){
     return(head(dataFrame %>% arrange(dataFrame[chosenArr])  ))
   } else {
     return(head(dataFrame %>% arrange(desc(dataFrame[chosenArr]) )    ))
   }
  
}


# MOVIELENS
usersMap = function(choices,param){  # STRINGA
  if (param  == "O"){
    # OCCUPATION MAP
    occID = workTable[workTable$workType == choices[2],]$workID
    dati = left_join(users %>% filter(occupation == occID), ratings, by = "userid" ) %>% group_by(userid) %>% summarise(rating = mean(rating), zip = unique(zip)) 
    dati = dati %>% group_by(zip) %>% summarise(rating = mean(rating),userCount = n())
    dati = left_join(dati,uszips  ,by="zip") 
    dati = dati %>% filter(!is.na(lat))
    plot = plot_usmap(data = dati,values = "userCount",labels = (choices[1] == "YES") , label_color = "white") +labs(title = paste("<",toupper(choices[2]),"> USERS COUNT BY ZIPCODE",sep=""))  +  scale_fill_continuous( low = "red", high = "green", name = "USERS COUNT", label = scales::comma ) + theme(legend.position = "right")
    return(plot)
  } else {
    movieGenreID = (movies %>% filter(grepl(choices[2],genres)))$movieid
    meanUserRatings = ratings %>% filter(movieid %in% movieGenreID)  %>% group_by(userid) %>% summarise(MeanRating = mean(rating))
    head(meanUserRatings)
    
    meanUserRatings = left_join(meanUserRatings,users %>% select(userid,zip),by="userid")
    head(meanUserRatings)
    
    meanUserRatings = meanUserRatings %>% group_by(zip) %>% summarise(rating = mean(MeanRating))
    head(meanUserRatings)
    
    # aggiungere info geografiche per creare la mappa
  
    prova = left_join(meanUserRatings,uszips ,by="zip") %>% select(rating,zip,lat,lng,fips)
    
    prova = prova %>% filter(!is.na(lat))
    plot = plot_usmap(data = prova, values = "rating",labels = (choices[1] == "YES"), label_color = "white")+labs(title = paste("USERS MEAN RATING FOR -",toupper( choices[2]),"- MOVIES BY ZIPCODE",sep=""))   +  scale_fill_continuous( low = "red", high = "green", name = "USERS MEAN RATING", label = scales::comma ) + theme(legend.position = "right")
    
    return(plot)
  }
  
  
  
  
  
}


# OSCARS INTERACTIVE

oscarMap = function(chosenLic){
  

  bestNominees = oscars  %>% group_by(title) %>% summarise(nominees = n(),winCount = length(winner[winner]), loseCount = length(winner[!winner]))  %>% arrange(desc(nominees))
  
  bestNomineesGross = inner_join(bestNominees,gross,by="title")
  if (chosenLic == "NA"){
    bestNomineesGross = bestNomineesGross %>% filter(is.na(license))
  } else {
    bestNomineesGross = bestNomineesGross %>% filter(license == chosenLic)
  }
  
  
  plot = ggplot(bestNomineesGross, aes(x=year, y=gross, size = nominees, color = winCount, text=title)) + geom_point(alpha=0.5) + scale_size(range = c(1,5), name="NOMINEES") + scale_color_gradient(low="red",high="green")  + theme(legend.position="none")
  return(plot)

}
