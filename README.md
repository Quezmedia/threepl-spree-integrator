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

You'll use the brokers to do the job:

* `Nutracoapi::BrokerSpreeToThree.new.send_missing_orders_to_three_pl`

  It's responsible for getting the orders in Spree and sending them to 3PL

* `Nutracoapi::BrokerThreeToSpree.new.check_and_mark_orders_as_sent`

  It's responsible for checking the orders at 3PL, look for when they were shipped, and mark the orders at spree side as shipped.
