# Pre-requisites

* Docker

**OR**

* python
* pip
* mkdocs-material (it should install mkdocs automatically)

# Getting started

If you prefer to go with locally installed `python` and `pip`, then:

1. `pip install mkdocs-material`
2. `mkdocs serve` (binds to `http://localhost:8000`)

If you prefer going the `docker-compose` way:

1. `docker-compose up` (binds to `http://localhost:8000`)

If you prefer plain `docker`:

`docker run -it --rm -v ./:/docs -p 8000:8000 squidfunk/mkdocs-material mkdocs serve`

# Building 

Execute one of these (depending on your local setup):

1. `mkdocs build`
2. `docker-compose up mkdocs mkdocs build`
3. `docker run -it --rm -v ./:/docs -p 8000:8000 squidfunk/mkdocs-material mkdocs build`

# Guidelines for contributors

* When adding new pages it is preferable to have the filename with lowercase characters.
* Avoid using `h1` (i.e `# my header`) at places other than the page title. Also, note that having multiple `h1` 
  confuses the `Table of contents` section so please avoid that as well.
* If you are adding a `resource` like `PDF`, `image`, `XML` file, it should be placed under `./docs/assets/resources/`.
* When adding a link to a `resource`, please use `/assets/resources/path/to/the/asset`.

# Structure

We have divided the documentation into 3 sections:

1. User guide - pages with instructions for how to use Strongbox as a normal "user".
2. Developer guide - pages with instructions for developers who are interested in contributing.
3. Knowledge base - pages which explain some of our concepts as well as other important information.
