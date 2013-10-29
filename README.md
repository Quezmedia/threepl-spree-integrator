Nutracoapi
==========

It's responsible to get Orders made in a Spree e-commerce instance, and send it, via api, to 3PL.

Installation
------------

Add this line to your application's Gemfile:

    # Assuming you've submoduled it in vendor directory
    gem 'nutracoapi', :path => "vendor/nutracoapi"

Execute:

    $ bundle

Run the generator:

    $ bundle exec rails g nutracoapi:install

And then execute the migrations:

    $ bundle exec rake db:migrate

Usage
-----

The class `Nutracoapi::Broker` has two methods:

* `send_missing_orders_to_three_pl`

  It's responsible for getting the orders in Spree and send them to 3PL

* `mark_orders_as_sent`

  It's responsible for checking the orders at 3PL, look for when they were shipped, and mark the orders at spree side as shipped.
