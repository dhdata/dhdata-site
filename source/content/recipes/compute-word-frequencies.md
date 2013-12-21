---
layout: recipe
title: Compute word frequencies
category: strings
published: true
---

## Problem

You have a text and you want to see how often different words show up. You
don't care about the capitalization of the words, punctuation, or the most
common words in the text, also known as "stop words."

## Solution

The general approach is to break your text into words, or tokens, process the
words to remove capitalization, unwanted punctuation, and the common words
that you don't need, and then count how often each token appears in the list.

### CoffeeScript

We assume that your text is in the `text` variable and that your list of stop
words is in the `stopwords` variable. The resulting word frequencies (or
counts) will be in the `counts` variable.

```coffeescript
words = (w.replace(/\W/,"") for w in text.toLowerCase().split(/\s+/)).sort()
counts = {}
count = 0
last_word = words[0]

for w in words
  if w != last_word
    counts[last_word] = count if last_word not in stopwords
    count = 0
    last_word = w
  count += 1
counts
```

Most of the work to convert your text into tokens is done in the first line.
We sort the words so that we can compute the counts without having to do a
hash lookup for each word.

Lines 2&ndash;4 set up the variables we need to efficiently run through the
words and compute their counts.

### Haskell

```haskell
foldl (\m w -> M.insertWith (+) w 1 m) M.empty
. filter (not . flip S.member stopwords)
. filter (not . null)
. map (map toLower)
. splitRegex (mkRegex "\\W+")
```

### Perl 5

We assume that your text is in the `$text` variable and that your list of stop
words is in the `@stopwords` variable. The resulting word frequencies (or
counts) will be in the `%counts` variable.

```perl
my @words = sort map { s/\P{Alnum}//; $_ } split(/\p{Space}/, lc $text);

my ($count, $last_word, %counts) =
   (     0,  $words[0]         );

while(my($k, $w) = each @words) {
  if($w ne $last_word) { 
    $counts{$last_word} = $count;
    $count = 0;
    $last_word = $w;
  }
  $count ++;
}
delete @counts{@stopwords};
```

### Perl 6

We assume that your text is in the `$text` variable and that your list of stop
words is in the `@stopwords` variable. The resulting word frequencies (or
counts) will be in the `%counts` variable.

```perl
my %counts = $text.lc.match(/<alnum>+/, :g)
            .grep({ $_ ne any(@stopwords) })
            .classify({ $_ })
            .map({ $_.key => $_.value.elems });
```

**N.B.: We've introduced whitespace into the above snippet to improve
**readability. [Rakudo](http://rakudo.org/) may show parse errors unless you
**remove the whitespace.

### Python

We assume that your text is in the `text` variable and that your list of stop
words is in the `stopwords` variable. The resulting word frequencies (or
counts) will be in the `counts` variable.

```python
import re
wordlist = re.compile(r'\W+', re.UNICODE).split(text.lower())
wordlist = [w for w in wordlist if w not in stopwords]
wordfreq = [wordlist.count(w) for w in wordlist]
counts = dict(zip(wordlist,wordfreq))
```

### Ruby

We assume that your text is in the `text` variable and that your set of stop
words is in the `stopWords` variable. The resulting frequencies (or counts)
are the result of the following expression.

```ruby
counts = text.
         downcase.
         split(/\W+/).
         reject{ |w| stopWords.include?(w) }.
         group_by { |w| w }.
         inject({}) { |h, (w, ws)| h[w] = ws.size; h }
```



### Scala

We assume that your text is in the `text` variable and that your set of stop
words is in the `stopWords` variable. The resulting word frequencies (or
counts) are the result of the following expression.

```scala
text.toLowerCase.split("\\W+").filterNot(stopWords).groupBy(identity).mapValues(_.size)
```

## Discussion

The details in the solutions are based on what you might need if you are
working with textual materials such as transcriptions, but the ideas work for
anything that you can represent as a string. As long as you can map your items
of interest to a set of strings, and map those strings back to your items of
interest, you can use the solutions to count how often different items show
up. For example, you could count the frequency of an author in a library if
you represented each book by the author's name. Instead of a word list, you
would have an author list.

## See Also

The tutorial on ["Computing
Frequencies"](http://programminghistorian.org/lessons/computing-frequencies)
at [The Programming Historian 2](http://programminghistorian.org/), which
inspired the Python solution.