---
layout: recipe
title: Read Data Into an RDF Graph
category: rdf
published: true
---

## Problem

You have RDF or RDF-like data that you would like to read in an RDF graph for
subsequent querying or processing.

## Solution

Create an in-memory or database-backed graph using your favorite language's RDF
libraries and import your data. The examples here use the default in-memory
storage provided by the libraries.

### Perl 5

The Perl community has a number of RDF-oriented packages. We use
[`RDF::Trine`](https://metacpan.org/pod/RDF::Trine) here because it is
easy to use.


```perl
use RDF::Trine;

my $store = RDF::Trine::Store::Memory->new();
my $graph = RDF::Trine::Model->new($store);

# Data from a URL
RDF::Trine::Parser->parse_url_into_model('http://dbpedia.org/resource/Semantic_Web');

# Data from a file
my $parser = RDF::Trine::Parser->guess_parser_by_filename($filename);
$parser -> parse_file_into_model($base_uri, $filename, $graph);
```


### Python

Python's [`rdflib`](https://github.com/RDFLib/rdflib) provides the basic tools
for loading and working with RDF. The
[`rdflib-json`](https://github.com/RDFLib/rdflib-jsonld) library provides
support for importing and serializing JSON-LD.

```python
import rdflib
graph = rdflib.Graph()

# Data from a URL
graph.load('http://dbpedia.org/resource/Semantic_Web')

# Data from a file
graph.load(filename);
```

### Ruby

When working with Ruby's `rdf` gem, you should install and use the `linkeddata`
gem as well since the latter gem installs a number of useful gems for various
RDF serializations.

```ruby
require 'rdf'
require 'linkeddata'

# Data from a URL
graph = RDF::Graph.load("http://dbpedia.org/resource/Semantic_Web")

# Data from a file
graph = RDF::Graph.new
RDF::Reader.open(filename) do |reader|
  reader.each_statement do |statement|
    graph << statement
  end
end
```


## Discussion

Reading RDF is the same regardless of how you end up storing the data, so this
recipe uses the default in-memory storage provided by default. Storing the
triples in a relational, graph, or other database is out of scope for this
recipe. Most of the time, storage management is separate from reading and
querying the data: using a database to store your graph doesn't change how you
read them into your graph.

Except for Ruby, all of the examples provide a one or two line way to load data
regardless of its source. If your data is published on the web, using the URL
loading form is the most convenient.
