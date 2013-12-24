---
layout: dataset
title: Dataset Template
license: open
url: "http://www.example.com/"
published: false
---

Description of the dataset.

## Data and Resources

### Resource Title

Description of the resource.

The following metadata fields are described in the DH Data guide on
[contributing a dataset](/dhdata/datasets/3-contributing-a-dataset/).

| Field     | Value                           |
| --------- | ------------------------------- |
| format    | Interactive Resource            |
| type      | Text                            |
| mime-type | text/html                       |
| url       | http://example.com/dataset-file |

### TEI Resource Example

This example resource is a link to a single TEI file.

| Field     | Value                           |
| --------- | ------------------------------- |
| format    | TEI                             |
| type      | Text                            |
| mime-type | text/tei+xml                    |
| url       | http://example.com/tei-file.xml |

### TEI Archive Example

This example resource is a link to an archive of TEI files. Typically, as in this example, such an archive is a tar or zip file. Compression is not part of the resource. Instead, compression is best handled by the client and server negotiating.

| Field     | Value                           |
| --------- | ------------------------------- |
| format    | TEI Archive                     |
| type      | Text Collection                 |
| mime-type | application/x-tar               |
| url       | http://example.com/tei-collection.tar |
