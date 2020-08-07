# recipe notebook

Simple web app for online cooking recipes created with Ruby on Rails web framework.
It serves as a final assignment work to the Ruby on Rails study group that I am part of.

## Install

### Technologies used
* Ruby 2.6.6
* Rails 6.0.3
* Sqlite3
* Puma server


### Clone the repository
```shell
https://github.com/nikolatriki/recipe_notebook.git
```
Navigate to the folder that was created after cloning
```shell
cd recipe_notebook
```
### Check your Ruby version

```shell
ruby -v
```

You should be using `ruby 2.6.6`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv):

```shell
rbenv install 2.6.6
```

### Install dependencies

You should be using [Bundler](https://github.com/bundler/bundler):
```shell
bundle install
```

### Initialize the database
 ```shell
rails db:create db:migrate db:seed
```

## Server
From the comman line start the local server Puma

```shell
rails s
```

Finally, in your web browser type `localhost:3000` to start the app.
