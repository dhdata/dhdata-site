---
title: Translate BRL-encoded Braille to 6-dot Unicode
category: strings
layout: recipe
---

## Problem

You have the BRL-encoded Braille translation of some text, but you need to display the 6-dot SimBraille to show how the Braille would appear when embossed.

## Solution

Because the BRL encoding maps each 6-dot pattern to a unique character, you can translate the BRL encoding to Unicode simply by mapping each ASCII character to the appropriate Unicode code point.

### Perl 5

We assume that the BRL-encoded text is in `$text`. The resulting Unicode-encoded string will be in `$out`. Note that for this code, we have produced the HTML-escaped version of the Unicode.

```perl
my $base = 10240;
my %ascii2unicode = (
  ' ' => 0,
  'a' => 1, 'b' => 3, 'c' => 9, 'd' => 25, 'e' => 17, 'f' => 11,
  'A' => 1, 'B' => 3, 'C' => 9, 'D' => 25, 'E' => 17, 'F' => 11,
  'g' => 27, 'h' => 19, 'i' => 10, 'j' => 26,
  'G' => 27, 'H' => 19, 'I' => 10, 'J' => 26,
    
  'k' => 5, 'l' => 7, 'm' => 13, 'n' => 29, 'o' => 21, 'p' => 15, 
  'K' => 5, 'L' => 7, 'M' => 13, 'N' => 29, 'O' => 21, 'P' => 15, 
  'q' => 31, 'r' => 23, 's' => 14, 't' => 30,
  'Q' => 31, 'R' => 23, 'S' => 14, 'T' => 30, 

  'u' => 37, 'v' => 39, 'x' => 45, 'y' => 61, 'z' => 53,
  'U' => 37, 'V' => 39, 'X' => 45, 'Y' => 61, 'Z' => 53,
  '&' => 47, '=' => 63, '(' => 55, '!' => 46, ')' => 62,

  '*' => 33, '<' => 35, '%' => 41, '?' => 57, ':' => 49,
  '$' => 43, ']' => 59, '}' => 59, '\\' => 51, '{' => 42, 
  'W' => 58, 'w' => 58, 
    
  '1' => 2, '2' => 6, '3' => 18, '4' => 50, '5' => 34, '6' => 22,
  '7' => 54, '8' => 38, '9' => 20, '0' => 52,
   
  '/' => 12, '+' => 44, '#' => 60, '>' => 28, "'" => 4, '-' => 36,

  '@' => 8, '^' => 24,  '_' => 56, '"' => 16, '.' => 40, ';' => 48,
  ',' => 32,
  '|' => 51,
  '~' => 24,
);
my $out = "";
my $n = length($text);
my $ch;
for($i = 0; $i < $n; $i++) {
  $ch = substr($text, $i, 1);
  if(exists $ascii2unicode{$ch}) {
    $out .= sprintf("&#%d;", $base + $ascii2unicode{$ch});
  }
  else {
    $out .= $ch;
  }
}
```

### PHP

We assume that the BRL-encoded text is in `$text`. The resulting Unicode-encoded string will be in `$out`. Note that for this code, we have produced the HTML-escaped version of the Unicode.

```php
$base = 10240;
$ascii2unicode = array(
  ' ' => 0,
  'a' => 1, 'b' => 3, 'c' => 9, 'd' => 25, 'e' => 17, 'f' => 11,
  'A' => 1, 'B' => 3, 'C' => 9, 'D' => 25, 'E' => 17, 'F' => 11,
  'g' => 27, 'h' => 19, 'i' => 10, 'j' => 26,
  'G' => 27, 'H' => 19, 'I' => 10, 'J' => 26,
    
  'k' => 5, 'l' => 7, 'm' => 13, 'n' => 29, 'o' => 21, 'p' => 15, 
  'K' => 5, 'L' => 7, 'M' => 13, 'N' => 29, 'O' => 21, 'P' => 15, 
  'q' => 31, 'r' => 23, 's' => 14, 't' => 30,
  'Q' => 31, 'R' => 23, 'S' => 14, 'T' => 30, 

  'u' => 37, 'v' => 39, 'x' => 45, 'y' => 61, 'z' => 53,
  'U' => 37, 'V' => 39, 'X' => 45, 'Y' => 61, 'Z' => 53,
  '&' => 47, '=' => 63, '(' => 55, '!' => 46, ')' => 62,

  '*' => 33, '<' => 35, '%' => 41, '?' => 57, ':' => 49,
  '$' => 43, ']' => 59, '}' => 59, '\\' => 51, '{' => 42, 
  'W' => 58, 'w' => 58, 
    
  '1' => 2, '2' => 6, '3' => 18, '4' => 50, '5' => 34, '6' => 22,
  '7' => 54, '8' => 38, '9' => 20, '0' => 52,
   
  '/' => 12, '+' => 44, '#' => 60, '>' => 28, "'" => 4, '-' => 36,

  '@' => 8, '^' => 24,  '_' => 56, '"' => 16, '.' => 40, ';' => 48,
  ',' => 32,
  '|' => 51,
  '~' => 24,
);
$out = "";
$n = strlen($text);
for($i = 0; $i < $n; $i++) {
  $ch = $text[$i];
  if(array_key_exists($ch, $ascii2unicode)) {
    $out .= sprintf("&#%d;", $base + $ascii2unicode[$ch]);
  }
  else {
    $out .= $ch;
  }
}
```

## Discussion

There are several ways you can represent the correspondence between the BRL symbol and the Unicode code point. In the above code, we have chosen to represent this as a dictionary mapping each BRL symbol to the offset of the Unicode code point from the base Braille Unicode code point. This allows us to treat each of the 6-dot patterns as a binary number in which the 1s represent visible dots in the pattern. A more efficient way to store the correspondence would be to have each of the BRL symbols be in a string where their placement in the string was based on their offset from the base Braille Unicode code point, but this could lead to slower execution in some languages. Assuming that we are not translating megabytes or gigabytes at a time, the code in this section should be sufficient.