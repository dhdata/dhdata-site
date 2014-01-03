---
title: Geometry
layout: recipe_collection
published: true
changefreq: weekly
---

Geometry and geography are sufficiently different that they warrant different
chapters. Many of the recipes you find here, you will also find in the
Geography section with modifications to work on a planetary surface such as
the Earth. The recipes in this section that work on a sphere assume a perfect
sphere, which won't always work for real geography. Likewise, algorithms that
assume a perfectly flat surface won't always work for geographic problems,
even when the research area is small, such as a few square miles around a
village.

## Coordinate Systems

The recipes in this chapter assume you are using Cartesian coordinates. Other
coordinate systems can make problems easier to work with, but you will need to
transform points from the other system to the Cartesian coordinate system if
you want to use the recipes. Here, we provide some formulas for transforming
between other common coordinate systems and Cartesian coordinates. For a more
complete list of coordinate systems and their transforms to or from Cartesian
coordinates, see [the list of canonical coordinate transformations](http://en.
wikipedia.org/wiki/List_of_canonical_coordinate_transformations).

### Polar coordinates

Polar coordinates consist of a radius (\\(r\\)) and an angle (\\(\theta\\)) in
two dimensions. The angle, \\(\theta\\), is measured in a counterclockwise
fashion from the horizontal axis (\\(y=0\\) and \\( x \gt 0\\)).

$$\\\\begin{array}{rcl}
 x &=& r \cos \theta \\\\\\
 y &=& r \sin \theta \\\\\\
 r &=& \sqrt{x^2 + y^2} \\\\\\
 \theta &=& \mbox{atan2}(y,x) 
\\\\end{array}$$

\\(\mbox{atan2}\\) is defined as a variant of the \\(\tan^{-1}\\) function:

$$ \mbox{atan2}(y,x) = \left\\{ \\begin{array}{ll}
\tan^{-1}\left(\tfrac{y}{x}\right) & \mbox{if } x \gt 0 \\\\\\
\tan^{-1}\left(\tfrac{y}{x}\right) + \pi & \mbox{if } x \lt 0 \mbox{ and } y \ge 0 \\\\\\
\tan^{-1}\left(\tfrac{y}{x}\right) - \pi & \mbox{if } x \lt 0 \mbox { and } y \lt 0 \\\\\\
\tfrac{\pi}{2} & \mbox{if } x = 0 \mbox{ and } y \gt 0 \\\\\\
-\tfrac{\pi}{2}& \mbox{if } x = 0 \mbox{ and } y \lt 0 \\\\\\
\mbox{ unde}\mbox{fined } & \mbox{if } x = 0 \mbox{ and } y = 0
\\end{array}\right.$$

### Spherical coordinates

Spherical coordinates add a second angle (\\(\phi\\)) to the polar coordinate
system.

$$\\begin{array}{rcl}
 x &=& r \sin \theta \cos \phi \\\\\\
 y &=& r \sin \theta \sin \phi \\\\\\
z &=& r \cos \theta \\\\\\
r &=& \sqrt{x^2 + y^2 + z^2} \\\\\\
\theta &=& \cos^{-1}\left(\tfrac{z}{r}\right) \\\\\\
\phi &=& \mbox{atan2}(y, x)
\\end{array}$$

### Cylindrical coordinates

Cylindrical coordinates add a second length (\\(z\\)) to the polar coordinate
system. Instead of using a radius measuring the distance from the origin to
the point, the cylindrical coordinate system uses the distance from the origin
to the projection of the point on the plane at \\(z=0\\) as a radius
replacement, \\(\rho\\).

$$\\begin{array}{rcl}
x &=& \rho \cos \theta \\\\\\
 y &=& \rho \sin \theta \\\\\\
 z &=& z \\\\\\
 \rho &=& \sqrt{x^2 + y^2} \\\\\\
 \theta &=& \mbox{atan2}(y,x) 
\\end{array}$$
