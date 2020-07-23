# README

Store Finder is a small full-stack application to find local dealers.

The dealer data is fetched from Salesforce and displayed in a map and list view
in the front-end.

The application is written in Ruby on Rails with a SQLite database and React.js
on the frontend.

## To run the application locally:

1. Copy the config file

Run:
```
cp config/salesforce.yml.example config/salesforce.yml
```
and fill in the real username, password, security token, client id and secret. 

2. Start the rails server with:

```
bundle exec rails s
```

3. Visit `localhost:3000` in your browser to see the app up-and-running

When the application is loaded for the first time, all dealers are fetched from
Salesforce and stored in a local database.

### To consume updates and deletions from Salesforce:

Run the following consumers locally, without closing the terminal windows:

```
bundle exec rake salesforce:run_created_consumer
bundle exec rake salesforce:run_updated_consumer
bundle exec rake salesforce:run_deleted_consumer
```

The consumers consume account creation / update / and deletion events from the
Salesforce Streaming API and update the local records accordingly.

