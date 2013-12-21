---
title: Find the direction from one point to another point (2D coordinates)
category: geometry
layout: recipe
published: true
---
## Problem

You have two points and you want to find out the direction from one to the other in a two-dimensional coordinate system.

## Solution

The direction from one point to another is the angle between some reference
line and the line passing through both points, measured counterclockwise. When
working in polar coordinates, this reference line is the line from the origin
of the coordinate system and passing along the horizontal axis (i.e., heading
"east"). When working with directions, we tend to think of the positive
vertical axis (i.e., "north") as the reference line.

To find the direction, simply convert cartesian coordinates to polar
coordinates and shift the angle as appropriate for your desired reference
line. The code snippets here do not shift the direction, so an angle of
\\(0\\) radians is along the positive \\(x\\) axis and an angle of
\\(\frac{\pi}{2}\\) radians is along the positive \\(y\\) axis.

### CoffeeScript

We assume that the points are `p1` and `p2` with properties `.x` and `.y`.

```coffeescript
theta = Math.atan2(p2.y - p1.y, p2.x - p1.x)
```

### Perl 5

We assume that the points are hashes `%p1` and `%p2` with keys `x` and `y`.

```perl
$theta = atan2($p2{'y'}-$p1{'y'}, $p2{'x'}-$p1{'x'});
```

### Postgres 9.2

We assume that columns `col1` and `col2` contain geometric points. Note that
Postgres only works with two-dimensional points.

```postgresql
SELECT atan2((col2-col1)[1], (col2-col1)[0]) FROM "table";
```

### Ruby

We assume that the points are hashes `p1` and `p2` with keys `x` and `y`.

```ruby
theta = Math.atan2(p2['y']-p1['y'], p2['x']-p1['x'])
```

## Discussion

If we imagine a circle with unit radius centered on the first point (`p1` in
the code snippets), then the arctangent is the shortest distance around the
circle we must travel to get from the horizontal axis (positive \\(x\\) axis)
to the line drawn between the points, assuming that we're measuring the angle
in radians. Remember that the circumference of a circle is \\(2\pi\\) times
the radius. If the radius is \\(1\\) (a unit circle), then the circumference
is \\(2\pi\\), which is how many radians there are in a full circle,
equivalent to \\(360^\circ\\).

Typical implementations of `atan2` return angles between \\(-\pi\\) and
\\(\pi\\) (equivalent to \\(-180^\circ\\) to \\(180^\circ\\)). Converting
between radians and degrees is simple enough: multiply by \\(180\\) and divide
by \\(\pi\\).
