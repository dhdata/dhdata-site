---
layout: recipe
title: Export RDF From a Graph
category: rdf
published: true
---

## Problem

You have data in an RDF graph and want to export it as RDF/XML, JSON-LD, or
another RDF serialization.

## Solution

Use the export or writing functions available in the RDF library you use to
build your graph. The examples here assume that you are using the graphs
produced in the recipe "[Read Data Into an RDF
Graph](./read-data-into-an-rdf-graph.html)."

### Perl 5

```perl
use RDF::Trine::Serializer;
use RDF::Trine::Exporter::CSV;

# Create serializer for a given format
my $serializer = RDF::Trine::Serializer->new($format);

# Create serializer based on HTTP content negotiation
my $serializer = RDF::Trine::Serializer->negotiate(
                   request_headers => $request_headers
                 );

# Create serializer for creating CSV
my $serializer = RDF::Trine::Exporter::CSV->new();

# Serialize to a string
my $string = $serializer->serialize_model_to_string($graph);

# Serialize to a file
open my $fh, ">", $filename;
$serializer->serialize_model_to_file($fh, $graph);
close $fh;
```

`RDF::Trine` supports the following serialization formats:
- CSV
- N-Quads
- N-Triples
- RDF/JSON
- RDF/XML
- TriG
- TSV
- Turtle

### Python

```python
import rdflib

# Serialize to a string
string = graph.serialize(format='n3')

# Serialize to a file
fh = open(filename, "w")
fh.write(graph.serialize(format='n3'))
fh.close()
```

`rdflib` has serializers for the following formats:
- N-Quads
- N-Triples
- RDF/XML
- TriG
- TriX
- Turtle

### Ruby

We make use of the `json-ld` gem in this example. Other serialization formats
work the same way.

```ruby
require 'rdf'
require 'linkeddata'
require 'json/ld'

# Serialize to a string
string = graph.dump(:jsonld)
string = graph.to_jsonld

# Serialize to a file
RDF::Writer.open(filename) { |writer| writer << graph }
```

A number of extensions support serialization in the following formats:
- JSON-LD
- N-Quads
- N-Triples
- RDF/JSON
- RDF/XML
- TriG
- TriX
- Turtle

## Discussion

As with reading RDF, serializing RDF does not depend on how you store your graph.

All of the libraries support the common serializations. RDF/XML is the safest
format when exchanging data with legacy applications. JSON-LD is becoming the
preferred format for web-based applications because it is JSON and does not
require a separate XML parser in the browser. JSON-LD is more compact than
RDF/JSON, the older JSON serialization of RDF.
