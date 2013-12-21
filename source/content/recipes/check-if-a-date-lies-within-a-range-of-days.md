---
title: Check if a date lies within a range of days
category: dates-and-times
layout: recipe
published: true
---
## Problem

You want to know if a particular date lies within a range of days, and you
don't care about the time of day.

## Solution

In general, you want to see if your date in question is on or after the first
day in the range and on or before the last day in the range.

### Perl 5

For this solution, we assume that the `$startdate` and `$enddate` variables
hold the start and end dates of the range and that the `$date` variable holds
the date in question.

```perl
($startdate, $enddate) = ($enddate, $startdate) if $startdate > $enddate;
$startdate -> truncate( to => 'day' );
$enddate -> truncate( to => 'day' );
$date -> truncate( to => 'day' );

if( $startdate <= $date and $date <= $enddate) {
  # $date is in the range of days indicated by $startdate and $enddate
}
```

You may also use a `DateTime::Span` object.

```perl
($startdate, $enddate) = ($enddate, $startdate) if $startdate > $enddate;
$startdate -> truncate( to => 'day' );
$enddate -> truncate( to => 'day' );
$date -> truncate( to => 'day' );

my $span = DateTime::Span->from_datetimes(
  start => $startdate,
  end   => $enddate,
);

if($span->contains($date)) {
  # $date is in the range of days indicated by $startdate and $enddate
}
```

## Discussion

The basic calculation here isn't difficult. It's a simple comparison against a
beginning and ending value as would be done regardless of units (e.g.,
checking that a distance is between two values). However, because many
date/time libraries track dates and times down to fractions of a second, you
need to decide which units you want to use (seconds, minutes, hours, days,
etc.) and truncate the date/time to those units before doing any comparisons.
