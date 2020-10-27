# Pre-requisites

* Docker

**OR**

* python3
* pip
* mkdocs-material (it should install mkdocs automatically)
* mkdocs-markdownextradata-plugin 
* mkdocs-git-revision-date-plugin

# Getting Started

If you prefer to go with locally installed `python` and `pip`, then:

1. `pip install -r requirements.txt`
2. `mkdocs serve` (binds to `http://localhost:8000`)

If you prefer going the `docker-compose` way:

1. `docker-compose up` (binds to `http://localhost:8000`)

If you prefer plain `docker`:

`docker run -it --rm -v ./:/docs -p 8000:8000 strongboxci/mkdocs:base mkdocs serve`

# Building 

Execute one of these (depending on your local setup):

1. `mkdocs build`
2. `docker run -it --rm -v ./:/docs -p 8000:8000 strongboxci/mkdocs:base mkdocs build`

# Live Pre-view:

Run the following and then browse to `localhost:8000`:
```
docker-compose up
```

# Guidelines For Contributors

* When adding new pages it is preferable to have the filename with lowercase characters.
* The first line of the page should be `# Page Title` - this helps in the indexing and search afterwards.
* Avoid using `h1` (i.e `# my header`) at places other than the page title. Having multiple `h1` 
  confuses the `Table of contents` section so please avoid that as well.
* If you are adding a `resource` like `PDF`, `image`, `XML` file, it should be placed under `./docs/assets/resources/`.
* Use `{{resource}}/path/to/asset` when linking to the resource. You can also use `{{url}}` and ``{{assets}}`` depending
  on which link you need.
* An exception is when linking to internal docs. Just use relative URLs to the markdown file. Mkdocs will take care to build the links. Follow [this guide][mkdocs internal-links].
* Please avoid using `inline links` and use `reference links` instead as it makes maintenance easier.  
  Avoid this example:  
  ```
  [I'm an inline-style link pointing to Strongbox](https://github.com/strongbox/strongbox) and here is some text in addition so that I can then add again the same link [I'm an inline-style link pointing to Strongbox](https://github.com/strongbox/strongbox)
  ```
  Prefered example:
  ```
  [I'm a reference link to Strongbox] and here is some text in addition so that I can then add again the same link [I'm a reference link to Strongbox], we can have this link repeating forever in the document and easily change it by just changing it from where reference is. ([I'm a reference link to Strongbox] just for fun.)  
  // insert somewhere at the bottom of the page 
  [I'm a reference link to Strongbox]: https://github.com/strongbox/strongbox
  ```


# Pull Requests

Shortly after you open a pull request, a hook will trigger live preview deployiment to netlify.com. You will be able to check your PR live at the link `deploy/netlify` provides in github's PR checks section.

# Structure

We have divided the documentation into 3 sections:

1. `User guide` - pages with instructions for how to use Strongbox as a normal "user".
2. `Developer guide` - pages with instructions for developers who are interested in contributing.
3. `Knowledge base` - pages which explain some of our concepts as well as other important information.

[mkdocs internal-links]: https://www.mkdocs.org/user-guide/writing-your-docs/#internal-links
