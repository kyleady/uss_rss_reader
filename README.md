# The USS RSS Reader!

The U.S.S RSS Reader is an rss feed reader developed by @kyleady and @howdoicomputer. The entire project started as a fun way to hone our programming and development skills. It runs on top of Ruby on Rails 5 and PostgreSQL and aims to be easy to use and deploy.

## Running it in Development

* Install and configure a Ruby version over 2.
* Install a PostgreSQL version over 9.
* Run `rails db:setup` to setup the database.
* Run `rails server` to startup Rails on `localhost:3000`

## How to Use

USS RSS Reader is pretty alpha quality at the moment so all we got is `/feeds/new` which will accept an RSS feed endpoint, store it and the last few articles returned from the parsed data to postgres, and then return you to a feed list.

---
