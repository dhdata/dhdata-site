---
title: Contributing a Dataset
layout: guide_page
published: true
---

Contributing information about a dataset is as simple as 
[forking](https://help.github.com/articles/fork-a-repo) the 
[GitHub repository for this site](https://github.com/dhdata/dhdata-site),
writing a short page about the dataset, and
[creating a pull request](https://help.github.com/articles/using-pull-requests).
Once the request is accepted, the dataset will be published on the site.

The easiest way to write a dataset page is to use [the editor](/editor) based on 
[Prose.io](http://prose.io/). The editor allows you to authenticate using your GitHub
account. Once you are authenticated, you will see a list of available content categories. If you have not yet forked the repository, then the editor will show you a short list of instructions with links to the appropriate GitHub pages.

To create an index page for a dataset, follow these steps.

## Step 1: Open the `datasets` folder

All dataset pages are in the `datasets` folder. Selecting the folder will list all of the
datasets.

<div class="text-center">
	<img src="/images/dhdata/datasets/folder-list.png" height="446" width="640" border="0" vspace="0" hspace="0" class="img-rounded" style="border: 1px solid silver;">
</div>

## Step 2: Create a new document

Selecting the `New File` button at the top of the page will open up an edit window with
the dataset template loaded.

<div class="text-center">
	<img src="/images/dhdata/datasets/new-file-button.png" height="222" width="640" border="0" vspace="0" hspace="0" class="img-rounded" style="border: 1px solid silver;">
</div>

## Step 3: Describe your dataset

The first section of the document is where you should describe your dataset. This section
should not have any section headings. If you feel the need to group together parts of
your dataset into subsections, then you should break your dataset into multiple sets with
one page per set.

## Step 4: List your resources

The second section is where you list each of the resources that make up your dataset. Each resource should follow the template: 

- a level three heading naming the resource,
- a short description of the resource, and
- a table of metadata about the resource.

The resource name should be unique within the dataset. DHData.Org uses this name to build
out URLs for resource-specific pages such as any resource preview.

The table should map the metadata keys to the appropriate values. DHData.Org uses only
the first two columns for each row, so you are free to add comments in a third column. 
However, the table is not shown on the site as-is, so any additinal columns will only be 
seen in the repository.

The following keys are used by DHData.Org. Additional metadata keys are shown on the site but are not used.

| Field    | Description |
| -------- | ----------- |
| format | Indicates the general format of the resource. This should be taken from [the list of file formats](./1-file-formats.html). |
| mime-type | Indicates the serialization of the resource. This should be one of the available [media content types](http://www.iana.org/assignments/media-types/media-types.xhtml). |
| type | Indicates the broad format class. This should be one of: Collection, Dataset, Interactive Resource, Moving Picture, Music, Service, Still Image, or Text. |
| url | Indicates the web address from which the resource may be retrieved. Fetching this URL should result in a file having the same MIME type as indicated in this metadata. Likewise, the file should contain data in the indicated format. |
