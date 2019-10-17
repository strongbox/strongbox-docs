# Upgrading Strongbox

We try to test everything as thorough as possible. However, Strongbox is still under development and sometimes things
could go wrong. This is why: 

!!! danger
    **YOU SHOULD ALWAYS CREATE A BACKUP OF YOUR [`STRONGBOX_VAULT`](./application-properties.md) and 
    [`STRONGBOX_HOME`](./application-properties.md) DIRECTORIES BEFORE PROCEEDING WITH AN UPGRADE!** 


## Steps to upgrade

1. Download the latest strongbox distribution version
2. Stop any running instance of Strongbox
3. Unzip `strongbox-distribution.tar.gz` in `STRONGBOX_HOME`  
   (but be sure to backup your `etc` directory before that!)
4. Start strongbox as normal
5. If there are database changes - they will be applied automatically.   
    **DO NOT STOP** Strongbox while the database is being upgraded - this could lead to a broken database!
6. Hopefully everything is up and running. 

In case an issue occurred - please report it in our issue tracker. 
