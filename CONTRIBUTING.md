# Contributing to DHData.Org

The mission of DHData.Org is to encourage the sharing of high-quality research
data and programming practices.

## Contributing Recipes

Recipes in [the cookbook](https://www.dhdata.org/cookbook/) are kept in this
repository's `source/recipes` directory. Before contributing a recipe, fork
this repository to your account. After creating your recipe and ensuring
everything builds, create a pull request to this repository.

When adding a new recipe, copy the template (`source/recipes/_copy-this-
template-to-create-a-new-recipe.md`) and replace the text in the various
sections.

In the frontmatter of the recipe, replace the date with the date on which you
created the recipe. Set the category to one of the following category names:

| Category Title | Category Name |
| -------------- | ------------- |
| Dates and Times | dates-and-times |
| Geometry       | geometry      |
| Statistical Analysis | statistical-analysis |
| Strings        | strings       |

Once you have added your recipe, run the `scripts/build.sh` script to make
sure everything builds without error. To build the site, you will need to
install ruby (1.9 or later) and [bower](http://bower.io/). See the Gemfile for
the gems that need to be installed.

If everything builds correctly, commit your new recipe (or changes to an
existing recipe) and push up to your repository on GitHub. From there, create
a pull request. After review, your recipe will be incorporated into the master
repository, triggering a rebuild of the site.

### Prose.io

We've added a configuration file to the repository for
[Prose.io](http://prose.io/). After forking this repostory, you can add and
edit recipes by going to the [Prose.io](http://prose.io/) site and selecting
your fork of the repository. You will be placed in the `source/recipes`
directory into which you can add your recipe.

### Recipe Licensing

All recipe contributions are assumed to be made under a [CC-BY] license. If
particular code snippets are available under a different Creative Commons
license, then this should be noted in the recipe along with links to the
source material from which the recipe is derived. Recipes not provided under a
Creative Commons license will not be accepted.

## Contributing Data

DHData.Org uses [CKAN]() to index information about openly licensed data that
may be of interest in digital humanities research. Due to the spam issue seen
in other open data index sites, we require that you register an organization
or be associated with an organization before you may add datasets to the
index.

### Registering an Account


### Registering an Organization

Once you have created an account in the CKAN section of DHData.Org, email
admin@dhdata.org from the email address you used in registering your account.
Send information about the organization, such as its name and website URL.
Once we have created the organization, we will associate you with the
organization and send you an email.
