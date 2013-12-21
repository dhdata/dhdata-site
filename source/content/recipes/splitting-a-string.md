---
layout: recipe
published: false
title: Splitting a String
category: strings
---

## Problem

You want to split a string based on some text or a regular expression.

## Solution

Most modern languages provide a function or method to accomplish this.

### CoffeeScript

```coffeescript
"foo bar baz".split " "
# => [ 'foo', 'bar', 'baz' ]
"foo bar baz".split /a/
# => [ 'foo b', 'r b', 'z' ]
```

### JavaScript

```javascript
"foo bar baz".split(" ");
/* => [ 'foo', 'bar', 'baz' ] */
"foo bar baz".split(/a/);
/* => [ 'foo b', 'r b', 'z' ] */
```

### Perl 5

```perl
split(" ", "foo bar baz");
# => [ 'foo', 'bar', 'baz' ]
split(/a/, "foo bar baz");
# => [ 'foo b', 'r b', 'z' ]
```

### Ruby

```ruby
"foo bar baz".split(" ")
# => [ 'foo', 'bar', 'baz' ]
"foo bar baz".split(/a/)
# => [ 'foo b', 'r b', 'z' ]
```

## Discussion

Most languages have a `split` function in some form. Ruby and JavaScript provide it as a method for String methods. Perl provides it as a global function. Most `split` forms will accept an additional parameter indicating the maximum number of strings into which the original string should be split.

## See Also

[Splitting a String](http://coffeescriptcookbook.com/chapters/strings/splitting-a-string) in the [CoffeeScript Cookbook](http://coffeescriptcookbook.com/) from which the above CoffeeScript example is taken.