#' Find if a point is in the convex hull of a set of points
#'
#' @param points A set of 2D points. Accepts a dataframe of x & y coords, a numeric vector or a list of vectors.
#' @param inhull A list of vectors of the points to be checked.
#'
#' @returns A vector of bools corresponding to if that point is in the convex hull or not.
#'
#' @examples
#' Points <- list(c(1,1),c(2,1),c(1,2),c(2,2),c(1.5,1.5),c(1.5,2.5))
#' check  <- list(c(1,1),c(1.5,1.5))
#' jarvis_march(Points, check)
in_hull <- function(points,inhull){
  jm <- jarvis_march(points,plot=FALSE)
  inthehull <- c()
  for(i in 1:length(inhull)){
    if((inhull[[i]][1]==jm[i,1]&&inhull[[i]][2]==jm[i,2])||(inhull[[i]][1]==jm[i,3]&&inhull[[i]][2]==jm[i,4])){
      inthehull[i] <- TRUE
    }
    else{
      inthehull[i] <- FALSE
    }
  }
  return(inthehull)
}