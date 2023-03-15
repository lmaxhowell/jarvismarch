#include <iostream>
#include <cmath>
#include <list>
#include <vector>
#include <algorithm>

#include <Rcpp.h>
using namespace Rcpp;

struct Point
{
    // define what a point is
    double x;
    double y;
    Point(double _x = 0.0, double _y = 0.0)
    {
        x = _x;
        y = _y;   
    }
    //adding these operators allows for maths to work and also 'sorting' a list/vector with <
    Point operator+(Point p)
    {
       return Point(x + p.x,y + p.y);
    }
    
    Point operator-(Point p)
    {
        return Point(x - p.x, y - p.y);
    }
    
    bool operator<(Point p)
    {
        if (x<p.x)
        {
            return true;
        }
        else if ((x==p.x)&&(y<p.y))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    bool operator==(Point p)
    {
        if ((x==p.x)&&(y==p.y))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    bool operator!=(Point p)
    {
        if ((x!=p.x)||(y!=p.y))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    // converts a vector to a point
    Point vec_to_point(std::vector<double> vec)
    {
        Point p(vec[0],vec[1]);
        return p;
    }
    // converts a point to a vector
    std::vector<double> point_to_vec(Point p)
    {
    	std::vector<double> vec{ p.x, p.y };
    	return vec;
    }
    // calculates the orientation of three points
    // 0 is linear
    // 1 is clockwise
    // -1 is anticlockwise
    int orientation(Point p, Point q, Point r)
    {
        double ori = (r.x-q.x)*(q.y-p.y)-(r.y-q.y)*(q.x-p.x);
        int entation {2};
        if (ori == 0)
        {
            entation=0;
        }
        else if (ori > 0)
        {
            entation=1;
        }
        else if (ori < 0)
        {
            entation=-1;
        }
        return entation;
    }
};

//[[Rcpp::export]]
std::list<std::vector<double> > jarvis_march_cpp(std::list<std::vector<double> > points)
{
    // making sure theres at least three points to caluclate the orientation of.
    if (points.size()<3)
    {
            std::cout << "Must be at least three points" << std::endl;
    }
    // convert each vector within the list to a point
    Point p1;
    std::list<Point> xys;
    for(std::vector<double>& xy_pair : points)
    {
      xys.push_back(p1.vec_to_point(xy_pair));
    }
    
    // also create the same but a vector of points as opposed to a list
    
    std::vector<Point> vecs(xys.begin(), xys.end());
    
    // sort the list and vector
    
    xys.sort();
    std::sort (vecs.begin(), vecs.end());
    
    // calculate the left most point's index within the list.
    
    Point left {vecs[0]};
    
    // initialise the output list
    std::list<Point> convex_hull;
    
    // initialise p
    int p {0};
    
    // run this while loop until the termination criteria is reached, where the next point in the convex hull
    // is the same as the first point i.e. we've reached the beginning again.
    while (true)
    {
    
        Point p3;
        convex_hull.push_back(vecs[p]); // add the last point to the hull.
        
        int q = (p+1) % vecs.size(); // make q the next point in the vector (looping around incase we're at the end
        // of the list 'points')
        
        // calculate the orientation. if it is anticlockwise update q to be that i, as it's got the 
        // most points clockwise to it.
        for (int i = 0; i < vecs.size(); i++)
        {
            if (p3.orientation(vecs[p],vecs[i],vecs[q])==(-1))
            {
                q=i;
            }
        }
        // we now have a q as the next point in the convex hull. set p to this so in the next iteration
        // it will add this point to the hull.
        p = q;
        // except don't add this point if we are back at the beginning of the hull! end the while loop.
        if (p==0)
        {
            break;
        }
    }
    // transform convex hull to a vector of points
    std::vector<Point> hull(convex_hull.begin(), convex_hull.end());
    // transform convex hull to a list of vectors
    std::list<std::vector<double>> convex_hull2;
    Point pnt;
    for (int j = 0; j < convex_hull.size(); j++)
    {
        convex_hull2.push_back(pnt.point_to_vec(hull[j]));
    }
    // return the convex hull
    return convex_hull2;
}
