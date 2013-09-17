== README

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
