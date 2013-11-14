# DHData Website

The DHData website is built as a static site in conjunction with a CKAN installation. This repository contains the source material from which the static site is built. This includes the guide to linked open data in the Digital Humanities and the data cookbook.

The mission of DHData.Org is to encourage the sharing of high-quality research data and programming practices.

## Contributing Recipes

Recipes in [the cookbook](https://www.dhdata.org/cookbook/) are kept in this repository's `source/recipes` directory. Before contributing a recipe, fork this repository to your account. After creating your recipe and ensuring everything builds, create a pull request to this repository.

When adding a new recipe, copy the template (`source/recipes/_copy-this-template-to-create-a-new-recipe.md`) and replace the text in the various sections.

In the frontmatter of the recipe, replace the date with the date on which you created the recipe. Set the category to one of the following category names:

| Category Title | Category Name |
| -------------- | ------------- |
| Dates and Times | dates-and-times |
| Geometry       | geometry      |
| Statistical Analysis | statistical-analysis |
| Strings        | strings       |

Once you have added your recipe, run the `scripts/build.sh` script to make sure everything builds without error. To build the site, you will need to install ruby (1.9 or later) and [bower](http://bower.io/). See the Gemfile for the gems that need to be installed.

If everything builds correctly, commit your new recipe (or changes to an existing recipe) and push up to your repository on GitHub. From there, create a pull request. After review, your recipe will be incorporated into the master repository, triggering a rebuild of the site.

#### Prose.io

We've added a configuration file to the repository for [Prose.io](http://prose.io/). After forking this repostory, you can add and edit recipes by going to the [Prose.io](http://prose.io/) site and selecting your fork of the repository. You will be placed in the `source/recipes` directory into which you can add your recipe.

#### Recipe Licensing

All recipe contributions are assumed to be made under a [CC-BY] license. If particular code snippets are available under a different Creative Commons license, then this should be noted in the recipe along with links to the source material from which the recipe is derived. Recipes not provided under a Creative Commons license will not be accepted.

## Contributing Data

DHData.Org uses [CKAN](http://ckan.org) to index information about openly licensed data that may be of interest in digital humanities research. Due to the spam issue seen in other open data index sites, we require that you register an organization or be associated with an organization before you may add datasets to the index.

### Registering an Account

To contribute datasets to the index, you will need to [register an account](https://www.dhdata.org/user/register) on the CKAN side of the site. Once you have registered an account, you will need to be associated with an existing organization or register a new organization.

### Registering an Organization

Once you have created an account in the CKAN section of DHData.Org, register your organization by sending the following template with your responses to [admin@dhdata.org](mailto:admin@dhdata.org?subject=Organization+Registration) from the email address you used in registering your account. Once we have created the organization, we will associate you with the organization and send you an email.

```
Organization Name:

Organization Slug (a short tag suitable as part of a URL):

URL of the Organization Logo or Image:

Secondary Administrator (name and email address):

Description:
```

### Requesting a Group

Groups are useful for collecting related datasets or datasets that might be useful for a particular part fo the Digital Humanities community. Groups need to be registered just as Organizations. You may request a group by sending the following template with your responses to [admin@dhdata.org](mailto:admin@dhdata.org?subject=Group+Request) from the email address you used in registering your account. Once we have created the group, we will associate you with the group and send you an email.

```
Group Name:

Group Slug (a short tag suitable as part of a URL):

URL of the Group Logo or Image:

Secondary Administrator (name and email address):

Description:
```

## License

Unless explicitely stated otherwise, the content in this repository is licensed under a [CC-BY](http://creativecommons.org/licenses/by/3.0/) license. All indexed datasets are licensed under their own terms.