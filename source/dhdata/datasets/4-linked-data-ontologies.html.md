---
title: Linked Data Ontologies
layout: guide_page
---
_This section contains material from [Linked Data](http://linkeddata.org/) available under the [CC-BY-SA](http://creativecommons.org/licenses/by-sa/3.0/) license._

Linked Data is about using the Web to connect related data that wasn't previously linked, or using the Web to lower the barriers to linking data currently linked using other methods. More specifically, Wikipedia defines Linked Data as "a term used to describe a recommended best practice for exposing, sharing, and connecting pieces of data, information, and knowledge on the Semantic Web using [URIs](http://en.wikipedia.org/wiki/URI) and [RDF](http://en.wikipedia.org/wiki/Resource_Description_Framework)."

This section contains links to common Linked Data ontologies and schemas. For each schema, we've included the abstract from the specification.

## Annotation

### Open Annotation

The [Open Annotation Core Data Model](http://www.openannotation.org/spec/core/) specifies an interoperable framework for creating associations between related resources, annotations, using a methodology that conforms to the Architecture of the World Wide Web. Open Annotations can easily be shared between platforms, with sufficient richness of expression to satisfy complex requirements while remaining simple enough to also allow for the most common use cases, such as attaching a piece of text to a single web resource.

An Annotation is considered to be a set of connected resources, typically including a body and target, where the body is somehow about the target. The full model supports additional functionality, enabling semantic annotations, embedding content, selecting segments of resources, choosing the appropriate representation of a resource and providing styling hints for consuming clients.

## Digital Facsimile

### Shared Canvas

The [Shared Canvas data model](http://www.shared-canvas.org/datamodel/spec/) specifies a linked data based approach for describing digital facsimiles of physical objects in a collaborative fashion. It is intended for use in the cultural heritage domain, although may be useful in other areas, and is designed around requirements derived from digitized text-bearing objects such as medieval manuscripts. Instances of the data model are consumed by rendering platforms in order to understand the relationships between the constituent text, image, audio or other resources. These resources are associated with an abstract Canvas, or parts thereof, via Open Annotations and the Annotations are grouped and ordered in OAI-ORE Aggregations.
