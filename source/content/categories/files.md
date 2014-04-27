---
layout: recipe_collection
title: Files
published: true
changefreq: weekly
---

Different operating systems represent files in different ways. Older systems
would present the file to programs based on the type of file. For example, some
files might be record based. Modern operating systems do not make this kind of
distinction between files. Everything is a single long record, byte stream, or
other abstraction. The application using the file must make any distinction
between parts of the file.

Microsoft Windows still distinguishes between text files and data files.
UNIX-based systems such as OS X make little distinction. When working with files
on Windows, you may need to specify that the file is text or not text when
opening or creating it in your application. You should let the operating system
know if you consider the file you're using to be a text file. This will let your
application work when you move from a UNIX-based system to a Microsoft Windows
system.

## Libraries

Several languages provide libraries for traversing file systems in a cross-platform
fashion. By using these libraries, you can write a program that will run on OS X,
Linux, and Microsoft Windows. The recipes in this section will use these libraries
when possible.

### Perl 5

If you need to manipulate file and directory names, you should use
[File::Spec](http://perldoc.perl.org/File/Spec.html). This module supports Unix
(including OS X), Apple Mac (before OS X), OS/2, Microsoft Windows, and VMS. For
copying or moving files, you should use
[File::Copy](http://search.cpan.org/~rjbs/perl-5.18.1/lib/File/Copy.pm).
