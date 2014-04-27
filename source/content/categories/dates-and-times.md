---
title: Dates and Times
layout: recipe_collection
published: true
changefreq: weekly
---

Many digital humanities projects have to deal with times and dates in some way.
We use dates to record a sequence of events or track the creation of a
particular work. Most projects will use a calendar that was in use at some point
in human history. Others might use an artificial calendar such as the one in
_The Lord of the Rings_. In this section, we'll focus on calendars that have a
historical basis.

Dershowitz and Reingold's _Calendrical Calculations_ is an excellent reference.
We won't cover all the calculations in this section. Instead, we'll point you to
the best libraries in various languages and show you how to use them to do the
calculations you need.

## Libraries

### Perl 5

The collection of packages produced by the [DateTime
project](http://datetime.perl.org/) is the best library. These can support a
wide range of calendars with infinite and semi-infinite timelines. The authors
based their work on _Calendrical Calculations_. They account for leap years,
months, days, and seconds, time changes, timezones, and astronomical
approximations such as new moons. Some of the calculations, such as leap
seconds, need you to keep your computer up to date with system updates.

The DateTime modules support the following calendars:

- Chinese (dates, but not times),
- Christian (combined Julain/Gregorian calendar with a user-settable reform date),
- Coptic,
- Coptic/Ethiopic,
- Discordian,
- French Revolutionary,
- Hebrew,
- Hijri or Islamic (but might not be accurate due to the use of observations in
the real calendar that algorithms can't model),
- Japanese,
- Julian,
- Mayan,
- Pataphysical (but with bugs related to week calculations), and
- the fictional Shire calendar by J. R. R. Tolkien.

You can create new calendars by following the general pattern used by the other
calendar modules.

The DateTime modules handle parsing dates and times in a wide range of formats
as well, including the various computational standards (ISO8601, RFCs 822 and
2822, W3CDTG, Excel, iCal) and database formats (MySQL, Postgres).

## See Also

[Falsehoods Programmers Believe About
Time](http://infiniteundo.com/post/25326999628/falsehoods-programmers-believe-about-time)

Edward M. Reingold, Nachum Dershowitz. _Calendrical Calculations (Millenium
Edition)_, 2nd ed. Cambridge University Press, Cambridge, UK 2002
