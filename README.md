
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jarvismarch

<!-- badges: start -->
<!-- badges: end -->

The goal of jarvismarch is to provide the means to find and plot the
convex hull of a set of points in 2D space.

## Installation

You can install the development version of jarvismarch like so:

``` r
library(devtools)
install_github("lmaxhowell/jarvismarch")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(jarvismarch)
Points <- list(c(1,1),c(2,1),c(1,2),c(2,2),c(1.5,1.5),c(1.5,2.5))
jarvis_march(Points, plot=TRUE)
```

<img src="man/figures/README-example-1.png" width="100%" />

    #>    x1  y1  x2  y2
    #> 1 1.0 1.0 2.0 1.0
    #> 2 2.0 1.0 2.0 2.0
    #> 3 2.0 2.0 1.5 2.5
    #> 4 1.5 2.5 1.0 2.0

## The Jarvis March Algorithm

The Jarvis March or ‘gift wrapping’ algorithm is designed to find the
subset of points within a set such that, when connected with straight
lines, the subset fully encases every point in the set. It does this by
finding a subset such that for any two successive points in the subset,
every other point in the set is anticlockwise to them. Pseudocode can be
found below. \### Pseudocode $S \subset \mathbb{R}^2$ is a set of points
with $|S|>3$. Let $p,q,i \in S$. The aim of this algorithm is to find a
subset of points that, when joined with straight lines, fully contain
every point in $S$.

1)  Initalise empty convex hull, initalise $p$ as the left most point in
    the set, and intitalise $q=0$.
2)  Begin WHILE
    1)  Add $p$ to the convex hull
    2)  Set $q$ as the next point in the set. If $p$ is at the end of
        the set, wrap around to the beginning ($q = (p+1) \mod |S|$).
    3)  Begin FOR each point $i$ in $S$
        1)  If the triple $p,i,q$ is anticlockwise, set that point $i$
            to be the new $q$.
    4)  End FOR.
    5)  Set $p=q$.
    6)  If this $p$ is the same as the first point in the convex hull,
        end WHILE.
