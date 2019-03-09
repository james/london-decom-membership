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

## Deploy to Heroku

Heroku makes it easy to host Ruby on Rails applications, and this app can be run on a free dino (although you will need to pay $7/month if you want HTTPS)

Before you can deploy this application to Heroku, you will need to get the above credentials from Eventbrite, but instead of putting them into .env, you will be asked for them.

To get started click the button below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
