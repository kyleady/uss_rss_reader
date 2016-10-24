[![Coverage Status](https://coveralls.io/repos/github/kyleady/uss_rss_reader/badge.svg)](https://coveralls.io/github/kyleady/uss_rss_reader)
[![Build Status](https://travis-ci.org/kyleady/uss_rss_reader.svg?branch=master)](https://travis-ci.org/kyleady/uss_rss_reader)

# The USS RSS Reader!

The U.S.S RSS Reader is an rss feed reader developed by @kyleady and @howdoicomputer. The entire project started as a fun way to hone our programming and development skills. It runs on top of Ruby on Rails 5 and PostgreSQL and aims to be easy to use and deploy.

## Running it in Development

* Install and configure a Ruby version over 2.
* Install a PostgreSQL version over 9.
* Run `rails db:setup` to setup the database.
* Run `rails server` to startup Rails on `localhost:3000`

## How to Use

USS RSS Reader is in alpha at the moment. Click 'Sign Up' or go to `/user/new` to create a new account on your local database. Once you are signed in as a user, you may add feeds in the side bar or by going to `/feeds/new`. Doing so will accept an RSS feed endpoint, store it and the articles returned from the parsed data to postgres, and then return you to the current user's feed list.

## Further Details

For more detailed information, please see the Wiki.

---
