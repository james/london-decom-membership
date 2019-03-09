# London Decompression Membership

## Setting up Eventbrite

This app uses Eventbrite to manage tickets. You will need to set up an
Eventbrite account and retrieve some credentials to set up the integration.

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
