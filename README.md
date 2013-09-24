## README

This is a sample app to show how to use Eligible API.

I added the api_key as a field for the users, so they can try it online on herokuapp, but in your app, you should not
create an api key for each one of your users in your company, instead your api key should remain in a secret
place and be used for all of the api calls.

In order to run the app locally, you will need to seed the database:
```
rake db:seed
```

The payer list is fetched from
https://eligibleapi.com/resources/information-sources

## General Instructions

This is a rails application, so you will need to get ruby and rails in order to run the application.

You can refer to this address in order to get instructions to install ruby: http://ruby.about.com/od/tutorials/a/installruby.htm

Then you can install rails by simply running:
```
gem install rails
```

You will also need a postgresql database. Once you get PostgreSQL installed, you need to setup the databse configuration,
by copying config/database.yml.example into config/database.yml and updating proper credentials on the file.

Once you are there, you need to bundle the gems for the project:
```
bundle
```

And now, create and seed the database:
```
rake db:create
rake db:migrate
rake db:seed
```

Finally, just run the application:
```
rails server
```

Enjoy
