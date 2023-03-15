#' A function that returns the plot of the convex hull of a set of points
#'
#' @param point A set of 2D points. Accepts a dataframe of two columns of x & y coords, a numeric vector alternating x and y coords, or a list of vectors.
#'
#' @return A ggplot2 object of the plot of the convex hull of the input set.
#' @examples
#' Points <- list(c(1,1),c(2,1),c(1,2),c(2,2),c(1.5,1.5),c(1.5,2.5))
#' jarvis_march_plot(Points)
#' g <- jarvis_march_plot(Points)
jarvis_march_plot <- function(point){
  # if its a list of vectors/points in a list
  if(class(point)=="list"){
    jm <- jarvis_march_cpp(point) 
    plotdata <- data.frame()
    for (i in 1:(length(point))){
      plotdata[i,1:2] <- c(point[[i]][1],point[[i]][2])
    }
    colnames(plotdata) <- c("x","y")
  }
  # if it is a dataframe
  else if (class(point)=="data.frame"){
    lst <- list()
    lstx <- as.list(point[,1])
    lsty <- as.list(point[,2])
    for(i in 1:length(lstx)){
      lst[[i]] <- append(lstx[[i]],lsty[[i]])
    }
    jm <- jarvis_march_cpp(lst)
    plotdata <- point
    colnames(plotdata) <- c("x","y")
  }
  # if its a single vector/list where it alternates x and y coords 
  else if(class(point)=="numeric"){
    lstx <- list()
    lsty <- list()
    for(i in 1:(length(point))){
      if(i%%2==0){
        lstx <- append(lstx,point[i])
      }
      else{
        lsty <- append(lsty,point[i]) 
      }
    }
    lst <- list()
    for(i in 1:length(lstx)){
      lst[[i]] <- append(lstx[[i]],lsty[[i]])
    }
    jm <- jarvis_march_cpp(lst)
    plotdata <- data.frame()
    for (i in 1:(length(lst))){
      plotdata[i,1:4] <- c(lst[[i]][1],lst[[i]][2])
    }
    colnames(plotdata) <- c("x","y")
  }
  else{
    print("Please input as a list, a vector or dataframe")
  }
  
  
  
  #### OUTPUT #####
  df <- data.frame()
  for (i in 1:(length(jm)-1)){
    df[i,1:4] <- c(jm[[i]][1],jm[[i]][2],jm[[i+1]][1],jm[[i+1]][2])
  }
  colnames(df) <- c("x1","y1","x2","y2")
  
  
  library(ggplot2)
  g <- ggplot(plotdata, aes(x,y)) + geom_point()
  for(j in 1:dim(df)[1]){
    g <- g + geom_segment(x = df[j,1], y = df[j,2], xend = df[j,3], yend = df[j,4], colour = "red")
  }
  g <- g + geom_segment(x = df[(dim(df)[1]),3], y = df[(dim(df)[1]),4], xend = df[1,1], yend = df[1,2], colour = "red")
  print(g)
  return(g)
}
