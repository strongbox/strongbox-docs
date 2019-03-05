# What are storages?

Storages are an abstraction that groups repositories on a logical level. For example, assume you would like to have repositories which are per environment, team, product, or client and that you would like to keep these repositories detached from the rest of your repositories so that you can maintain more clarity on the state of your repositories and dependencies. You can group them under their own storages. For example, let's assume you have product and you would like to be able to know which repositories you are using for it exactly. You can create a separate storage for this product and define these repositories under it.

You can also create a global storage that contains only remote repositories which you will be proxying. For each product, organization or client, you can then create separate storages which refer to the respective repositories in the global storage.

# Why use storages?

The main benefits of using storages are:

- A logical separation of repositories based on their type
- A layer of strictness in terms of repository and artifact separation
- A clearer view on the state of the repositories and dependencies

# The `storageId`

Each storage is identified by its unique Id. The `storageId` may contain:

- All letters from [English_alphabet](https://en.wikipedia.org/wiki/English_alphabet) (upper and lowercase)
- All [numerical digits](https://en.wikipedia.org/wiki/Numerical_digit)
- 3 special characters: `-` (dash), `_` (underscore) and `.` (dot)
