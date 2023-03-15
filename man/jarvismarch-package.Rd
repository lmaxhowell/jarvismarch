\name{jarvismarch-package}
\alias{jarvismarch-package}
\alias{jarvismarch}
\docType{package}
\title{
  A package that uses a C++ function to find and plot the convex hull of a set of   points.
}
\description{
  The convex hull is a set of points such that, when connected with straight lines, every other point in the set is contained within the convex hull. The method used in the jarvis march gift wrapping algorithm. Limited to the two dimensional case.
}
\details{
  The main function used is jarvis_march. This can take as input either a data frame with two variables (x and y coordinates respectively), a numeric vector that alternates x and y coordinates, or a list of vectors of the points, with each vector being the x and y coordinates of a point. It outputs a dataframe with four columns, denoting the x and y coordinates of two points that define the line segments cooresponding to the convex hull. There is also the function in_hull, which takes as input the set of points and a list of vectors of points that you want to check whether they are in the convex hull or not. It returns a vector of true and false values that correspond to whether the point is in the hull or not.
}
\author{
Lucas Max Howell, l.m.f.howell@lancaster.ac.uk.

Maintainer: Lucas Max Howell, l.m.f.howell@lancaster.ac.uk.
}
\references{
  For more information, start with https://en.wikipedia.org/wiki/Gift_wrapping_algorithm.
}
