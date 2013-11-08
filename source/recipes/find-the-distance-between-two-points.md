---
title: Find the distance between two points
category: geometry
layout: recipe
date: 2013-07-04
---
## Problem

You have the coordinates for two points and wish to find the distance between them.

## Solution

How you define the distance between two points depends on what you want to do with the distance. Generally, a distance measure is some function that allows you to produce a well-ordered set. Generally, the distance from \\(A\\) to \\(B\\) will be the same as the distance from \\(B\\) to \\(A\\): you can exchange the points in the computation and arrive at the same answer.

The general formula for distance, the Euclidean distance, is the square root of the sum of squares of the differences in the coordinates. For example, to find the distance between two points \\((x\_1,y\_1)\\) and \\((x\_2,y\_2)\\): 
$$d = \sqrt{(x\_2-x\_1)^2 + (y\_2-y\_1)^2}.$$

However, there are times when the rectilinear distance is more appropriate. This is the sum of the absolute differences in the coordinates. For our two points above, this would be
$$d = |x\_2-x\_1| + |y\_2-y\_1|.$$

The difference is that the Euclidean distance measure points on circles (\\(d\\) is the radius of the circle on which the point lies) while the rectilinear distance measures points on squares (\\(d\\) is the "radius" of the square on which the point lies). In three dimensions, these would be spheres and boxes respectively.

### CoffeeScript

We assume that the points are `p1` and `p2` with properties `.x` and `.y`.

```coffeescript
euclidian = Math.sqrt( Math.pow(p2.x-p1.x, 2) + Math.pow(p2.y-p1.y, 2) )
rectilinear = Math.abs(p2.x-p1.x) + Math.abs(p2.y-p1.y)
```

### Perl 5

We assume that the points are hashes `p1` and `p2` with keys `x` and `y`.

```perl
$euclidian = sqrt((p2{'x'}-p1{'x'})**2 + (p2{'y'}-p1{'y'})**2);
$rectilinear = abs(p2{'x'}-p1{'x'}) + abs(p2{'y'}-p1{'y'});
```

### Postgres 9.2

We assume that columns `col1` and `col2` contain geometric points. Postgres defines the distance between two points as the Euclidean distance. Note also that Postgres only works with two-dimensional points.

```postgresql
SELECT col1 <-> col2 as euclidian FROM "table";
```

## Discussion

Which distance formula you use should depend on what kind of problem you are working on and which formula works best in the language you are using. If you only need to group items by distance without having to use the distance to calculate things such as physical forces, for example when calculating the dimensionality of a dataset, then the rectilinear distance will give you better performance in general. The efficiency of the distance calculation also depends on how you represent the points. The best way to do this depends on the language, but you should be able to adapt any of the solutions in this section to different data structures without too much trouble.
