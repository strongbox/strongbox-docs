This is an example of how to use the Strongbox artifact repository manager with pip.

# Before you start

Make sure that your Strongbox instance is up and running. If you are new to Strongbox, please visit the [Installation](https://strongbox.github.io/user-guide/getting-started.html) page first.

# Requirements

You will need the following software installed on your machine to make this example working:

* [Python](https://www.python.org/) version 3 or higher
* [twine](https://pypi.org/project/twine/)
* [pip](https://pypi.org/project/pip/)

# The example project

The "Hello, World!" sample application for this can be found [here](https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-pypi).

# Pypi Example

This is an example of how to use the Strongbox artifact repository manager with `twine` and `pip`.

## The `setup.py` file

This file is the build script for setuptools. It tells setuptools about your package like its name, a description, the current version etc.The [Strongbox PyPI Example] contains sample [setup.py] file with pre-defined sample information.
This file

## The `setup.cfg` file

This file is used to define metadata information like description file name.

## The `LICENCE` file

This file is used to define license details.


For more details check the ["See also"] section below.

### How to deploy python package

Execute the following commands within your project folder.

This will build package: 

    python3 setup.py sdist bdist_wheel
    
The output should look like this:
    
    python3 setup.py sdist bdist_wheel   
    running sdist
    running egg_info
    creating hello_world_pypi.egg-info
    writing hello_world_pypi.egg-info/PKG-INFO
    writing dependency_links to hello_world_pypi.egg-info/dependency_links.txt
    writing requirements to hello_world_pypi.egg-info/requires.txt
    writing top-level names to hello_world_pypi.egg-info/top_level.txt
    writing manifest file 'hello_world_pypi.egg-info/SOURCES.txt'
    reading manifest file 'hello_world_pypi.egg-info/SOURCES.txt'
    writing manifest file 'hello_world_pypi.egg-info/SOURCES.txt'
    running check
    creating hello-world-pypi-1.0.0
    creating hello-world-pypi-1.0.0/hello-world-pypi
    creating hello-world-pypi-1.0.0/hello_world_pypi.egg-info
    copying files to hello-world-pypi-1.0.0...
    copying README.md -> hello-world-pypi-1.0.0
    copying setup.cfg -> hello-world-pypi-1.0.0
    copying setup.py -> hello-world-pypi-1.0.0
    copying hello-world-pypi/__init__.py -> hello-world-pypi-1.0.0/hello-world-pypi
    copying hello-world-pypi/helloworld.py -> hello-world-pypi-1.0.0/hello-world-pypi
    copying hello_world_pypi.egg-info/PKG-INFO -> hello-world-pypi-1.0.0/hello_world_pypi.egg-info
    copying hello_world_pypi.egg-info/SOURCES.txt -> hello-world-pypi-1.0.0/hello_world_pypi.egg-info
    copying hello_world_pypi.egg-info/dependency_links.txt -> hello-world-pypi-1.0.0/hello_world_pypi.egg-info
    copying hello_world_pypi.egg-info/requires.txt -> hello-world-pypi-1.0.0/hello_world_pypi.egg-info
    copying hello_world_pypi.egg-info/top_level.txt -> hello-world-pypi-1.0.0/hello_world_pypi.egg-info
    Writing hello-world-pypi-1.0.0/setup.cfg
    creating dist
    Creating tar archive
    removing 'hello-world-pypi-1.0.0' (and everything under it)
    running bdist_wheel
    running build
    running build_py
    creating build
    creating build/lib
    creating build/lib/hello-world-pypi
    copying hello-world-pypi/__init__.py -> build/lib/hello-world-pypi
    copying hello-world-pypi/helloworld.py -> build/lib/hello-world-pypi
    installing to build/bdist.macosx-10.12-x86_64/wheel
    running install
    running install_lib
    creating build/bdist.macosx-10.12-x86_64
    creating build/bdist.macosx-10.12-x86_64/wheel
    creating build/bdist.macosx-10.12-x86_64/wheel/hello-world-pypi
    copying build/lib/hello-world-pypi/__init__.py -> build/bdist.macosx-10.12-x86_64/wheel/hello-world-pypi
    copying build/lib/hello-world-pypi/helloworld.py -> build/bdist.macosx-10.12-x86_64/wheel/hello-world-pypi
    running install_egg_info
    Copying hello_world_pypi.egg-info to build/bdist.macosx-10.12-x86_64/wheel/hello_world_pypi-1.0.0-py3.7.egg-info
    running install_scripts
    adding license file "LICENSE" (matched pattern "LICEN[CS]E*")
    creating build/bdist.macosx-10.12-x86_64/wheel/hello_world_pypi-1.0.0.dist-info/WHEEL
    creating 'dist/hello_world_pypi-1.0.0-py3-none-any.whl' and adding 'build/bdist.macosx-10.12-x86_64/wheel' to it
    adding 'hello-world-pypi/__init__.py'
    adding 'hello-world-pypi/helloworld.py'
    adding 'hello_world_pypi-1.0.0.dist-info/LICENSE'
    adding 'hello_world_pypi-1.0.0.dist-info/METADATA'
    adding 'hello_world_pypi-1.0.0.dist-info/WHEEL'
    adding 'hello_world_pypi-1.0.0.dist-info/top_level.txt'
    adding 'hello_world_pypi-1.0.0.dist-info/RECORD'
    removing build/bdist.macosx-10.12-x86_64/wheel    


This will deploy python package to Strongbox.
    
    python3 -m twine upload --username admin --password password --repository-url http://localhost:48080/storages/storage-pypi/pypi-releases  dist/* --verbose

The output should look like this:

    python3 -m twine upload --username admin --password password --repository-url http://localhost:48080/storages/storage-pypi/pypi-releases  dist/* --verbose
    Uploading distributions to http://localhost:48080/storages/storage-pypi/pypi-releases
    Uploading hello_world_pypi-1.0.0-py3-none-any.whl
    100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 9.69k/9.69k [00:07<00:00, 1.38kB/s]
    Uploading hello-world-pypi-1.0.0.tar.gz
    100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 5.14k/5.14k [00:00<00:00, 7.30kB/s]

  
  
### How to install python package

Execute the following to install python package:

    pip3 install --extra-index-url http://localhost:48080/storages/storage-pypi/pypi-releases hello-world-pypi
    
The output should look like this:

    pip3 install --extra-index-url http://localhost:48080/storages/storage-pypi/pypi-releases hello-world-pypi
    Looking in indexes: https://pypi.org/simple, http://localhost:48080/storages/storage-pypi/pypi-releases
    Collecting hello-world-pypi
      Downloading http://localhost:48080/storages/storage-pypi/pypi-releases/packages/hello_world_pypi-1.0.0-py3-none-any.whl
    Processing /Users/ankit.tomar/Library/Caches/pip/wheels/95/70/6e/0f8362d968f0fef63006a07ba4158ac5d921fbcc664f976db3/pip_hello_world-0.1-cp37-none-any.whl
    Installing collected packages: pip-hello-world, hello-world-pypi
    Successfully installed hello-world-pypi-1.0.0 pip-hello-world-0.1
      
        
# See also

* [Python Packages User Guide](https://docs.python.org/3/distributing/index.html#publishing-python-packages)  
* [How to upload python package](https://medium.com/@joel.barmettler/how-to-upload-your-python-package-to-pypi-65edc5fe9c56)


[Strongbox Pypi Example]: https://github.com/strongbox/strongbox-examples/tree/master/hello-strongbox-pypi
[setup.py]: https://github.com/strongbox/strongbox-examples/blob/master/hello-strongbox-pypi/setup.py
["See also"]: #see-also