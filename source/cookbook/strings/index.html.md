---
title: Strings
layout: recipe_collection
---

Strings are composed of characters, which sounds innocent enough until you realize that different languages mean different things by "character." For some languages, like C, a character is 8 bits. Other languages, like C++, provide two different types of characters: the 8-bit character of C and the 16-bit or "wide" character. Still other languages, such as Ruby and Perl, don't provide anything resembling a character. Instead, they have strings that hide all of the details about how characters are strung together.

When working with scholarly text, use methods that understand Unicode in the encoding appropriate for the language. Consistency here will reduce the amount of debugging you will have to do when working with characters that aren't strict ASCII. Don't trust your language's Unicode handling. Read the documentation closely to see where you might run into problems.

See [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html) for a basic background on Unicode. It was written in 2003, so languages have developed better Unicode support in the meantime, but the article points out things you should watch for when working in your favorite language.