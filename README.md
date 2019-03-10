# London Decompression Membership

## Setting up Eventbrite

This app uses Eventbrite to manage tickets. You will need to set up an Eventbrite account and retrieve some credentials to set up the integration.

### Eventbrite Access Token

- visit https://www.eventbrite.com/account-settings/apps
- click 'Create a new app'
- Fill in details and submit
- Copy 'Your personal OAuth token' and put in .env as EVENTBRITE_TOKEN

### Eventbrite Event ID

- Create an event if you haven't already
- Go to the page to manage the event
- The URL should be something like `https://www.eventbrite.com/myevent?eid=11111`
- Copy the ID after `eid=` and put in .env as EVENTBRIGHT_EVENT_ID

### Running locally

To run this application locally for development, you will need to install:

- ruby (I recommend `rvm`, but you could use `rbenv` or any other technique)
- Postgresql (I use Postgres.app on OSX)

You then need to navigate to the repository's root and run:

- `bundle install` to install dependencies
- `rake db:setup` to setup the database

## Deploy to Heroku

Heroku makes it easy to host Ruby on Rails applications, and this app can be run on a free dino (although you will need to pay $7/month if you want HTTPS)

Before you can deploy this application to Heroku, you will need to get the above credentials from Eventbrite, but instead of putting them into .env, you will be asked for them.

To get started click the button below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Making admin users

There is a small admin interface to this application. To access it, you need to be logged in as a user with admin privileges. Currently this can only be done over the command line.

First, register as a normal user, and then run a Rails console. If you are working locally, then it is `rails console`. If you want to do this on a Heroku instance, then run `heroku run rails console`. Then run:

```
user = User.find_by(email: 'REPLACE_WITH_EMAIL_ADDRESS')
user.admin = true
user.save!
```

## Contributing

I would be ecstatic if some other people contributed some code. Please do so by forking this repository, making your changes there, and then making a Github Pull Request.

Please make sure that the test suite passes. To run the test suite, simply run `rake` from the repository root. If you are making functional changes, please create or update some rspec specs. I can help with this if you need.

### Using this for other events

Currently references to London Decompression are hardcoded in the code, as well as images, styles etc. So if you want to use this for another event, you will either need to fork this repository and edit them manually, or preferably make a Pull Request that makes it easy to customise these things! Or ask me to do it, and I'll see if I can make the time.
