---
title: File Formats
layout: guide_page
published: true
---

_This section contains material from the [Open Data
Handbook](http://opendatahandbook.org/) and [DCMI Metadata
Terms](http://dublincore.org/documents/dcmi-terms/) available under the [CC-
BY](http://creativecommons.org/licenses/by/3.0/) license._

Because the purpose of DH Data is to share open data and computable data, we
accept a limited list of file formats and types. If your data is not in one of
the formats listed on this page, it is not sufficiently open to be useful to
the larger digital humanities community without conversion. This is not an
indictment of the content, but of the particular file format used to represent
that content.

These resource data formats use the DCMI Type Vocabulary for the primary
classification followed by the file's serialization format. For each format,
we've linked to any standards documents and indicated the range of openness
stars a typical resource can earn.


## Collection

Collections are resources aggregating other resources. For example, an RSS
feed aggregates blog posts.

| Format | Specification | Openness |
| -------- | --------------- | ------------ |
| Atom | [Specification](http://www.ietf.org/rfc/rfc5023.txt) | $*(****)$ |
| ORE | [Specification](http://www.openarchives.org/ore/1.0/rdfxml.html) | $***(**)$ |
| RSS | [Specifications](http://www.rss-specifications.com/) | $*(****)$ |

## Dataset

Datasets are serializations of tabular or graph data such as tables, lists, or
databases. Datasets are useful for direct computation.

| Format | Specification | Openness |
| -------- | --------------- | ------------ |
| CSV | [Specification](http://tools.ietf.org/html/rfc4180) | $***$ |
| JSON | [Specification](http://www.ietf.org/rfc/rfc4627.txt) | $***$ |
| JSON-LD | [Specifications](http://json-ld.org/spec/latest/) | $****(*)$ |
| KML | [Specification](http://www.opengeospatial.org/standards/kml/) | $***(**)$ |
| OWL/XML | | $*****$ |
| RDF/JSON | |  $***(**)$ |
| RDF/N3 | | $***(**)$ |
| RDF/N-Triples | | $***(**)$ |
| RDF/Turtle | | $***(**)$ |
| RDF/XML | | $***(**)$ |
| TSV | [Specification](http://www.iana.org/assignments/media-types/text/tab-separated-values) | $***$ |

### JSON

JSON is a simple file format that is very easy for any programming language to
read. Its simplicity means that it is generally easier for computers to
process than others, such as XML.

### JSON-LD

JSON-LD is a form of JSON with contextual information that helps an
application know how to interpret the data. The JSON-LD data model is
comparable to RDF, but it is not a simple JSON serialization of RDF.

### RDF

A W3C-recommended format called RDF makes it possible to represent data in a
form that makes it easier to combine data from multiple sources. RDF data can
be stored in XML and JSON, among other serializations. RDF encourages the use
of URLs as identifiers, which provides a convenient way to directly
interconnect existing open data initiatives on the Web. RDF is still not
widespread, but it has been a trend among Open Government initiatives,
including the British and Spanish Government Linked Open Data projects. The
inventor of the Web, Tim Berners-Lee, has recently proposed a [five-
star](http://lab.linkeddata.deri.ie/2010/star-scheme-by-example/) scheme that
includes linked RDF data as a goal to be sought for open data initiatives.

### XML

XML is a widely used format for data exchange because it gives good
opportunities to keep the structure in the data and the way files are built
on, and allows developers to write parts of the documentation in with the data
without interfering with the reading of them. XML can be used as a
serialization format for RDF as well as a native document format for (X)HTML,
MEI, and TEI.

### Comma and Tab Separated Files

CSV files can be a very useful format because it is compact and thus suitable
to transfer large sets of data with the same structure. However, the format is
so spartan that data are often useless without documentation since it can be
almost impossible to guess the significance of the different columns. It is
therefore particularly important for the comma-separated formats that
documentation of the individual fields are accurate.

Furthermore it is essential that the structure of the file is respected, as a single omission of a field may disturb the reading of all remaining data in the file without any real opportunity to rectify it, because it cannot be determined how the remaining data should be interpreted.

## Image

A visual representation other than text. Image resources should not be "lossy"
unless their particular compression demonstrates an issue with the compression
or decompression algorithm. They should be useful for computation. For
example, an exemplar image demonstrating some particular difficulty for a
particular algorithm would be a useful Image resource.

| Format | Specification | Openness |
| -------- | --------------- | ------------ |
| GIF | [Specification](http://www.w3.org/Graphics/GIF/spec-gif89a.txt) | $*$ |
| JPG | [Specifications](http://www.w3.org/Graphics/JPEG/) | $*$ |
| JP2 | | $*$ |
| PNG | [Specifications](http://www.libpng.org/pub/png/spec/) | $*$ |
| TIFF | [Specification](http://partners.adobe.com/public/developer/en/tiff/TIFF6.pdf) | $*$ |

## Interactive Resource

- Openness: $*$

A resource that requires a user to interact with it for it to be understood or
useful. Examples include search pages that are not designed as a simple visual
representation of a REST API. We assume that Interactive Resources are HTML
pages.

## Moving Picture

- Openness: $*$

## Music

| Format | Specification | Openness |
| -------- | --------------- | ------------ |
| MEI | [Specifications](http://www.music-encoding.org/documentation/guidelines2013) | $***(**)$ |

## Service

| Format | Specification | Openness |
| -------- | --------------- | ------------ |
| REST | [Specification](http://en.wikipedia.org/wiki/Representational_state_transfer) | $***(**)$ |
| SPARQL | [Specification](http://www.w3.org/TR/sparql11-service-description/) | $***(**)$ |

## Still Image

## Text

| Format | Specification | Openness |
| -------- | --------------- | ------------ |
| HTML | [Specifications](http://www.w3.org/community/webed/wiki/HTML/Specifications) | $***(**)$ |
| PDF | | $*(*)$ |
| Plain Text | | $*$ |
| PostScript | | $*(*)$ |
| TEI | [Specification](http://www.tei-c.org/Guidelines/) | $***(**)$ |

### HTML

Nowadays much data is available in HTML format on various sites. This may well
be sufficient if the data is very stable and limited in scope. In some cases,
it could be preferable to have data in a form easier to download and
manipulate, but as it is cheap and easy to refer to a page on a website, it
might be a good starting point in the display of data.

Typically, it would be most appropriate to use tables in HTML documents to
hold data, and then it is important that the various data fields are displayed
and are given IDs which make it easy to find and manipulate data. Yahoo has
developed a tool
([http://developer.yahoo.com/yql/](http://developer.yahoo.com/yql/)) that can
extract structured information from a website, and such tools can do much more
with the data if it is carefully tagged.

### Plain Text

Plain text documents (.txt) are very easy for computers to read. They
generally exclude structural metadata from inside the document however,
meaning that developers will need to create a parser that can interpret each
document as it appears.

Some problems can be caused by switching plain text files between operating
systems. MS Windows, Mac OS X and other Unix variants have their own way of
telling the computer that they have reached the end of the line.

### TEI

TEI documents include structural metadata as well as the readable text of a
document. TEI documents that use URIs to reference controlled vocabularies can
be considered forms of linked data. Such documents under an open license can
earn [five stars](http://lab.linkeddata.deri.ie/2010/star-scheme-by-example/)
of openness.

### Text Document

Classic documents in formats like Word, ODF, OOXML, or PDF may be sufficient
to show certain kinds of data&mdash;for example, relatively stable mailing
lists or equivalent. It may be cheap to exhibit in, as often it is the format
the data is born in. The format gives no support to keep the structure
consistent, which often means that it is difficult to enter data by automated
means. Be sure to use templates as the basis of documents that will display
data for reuse, so it is at least possible to pull information out of
documents.

It can also support the further use of data to use typography markup as much
as possible so that it becomes easier for a machine to distinguish headings
(any type specified) from the content and so on. Generally it is recommended
not to exhibit in word processing format, if data exists in a different
format.
