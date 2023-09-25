# London Decompression Membership

Test status: [![CircleCI](https://circleci.com/gh/james/london-decom-membership.svg?style=svg)](https://circleci.com/gh/james/london-decom-membership)

## Setting up Eventbrite

This app uses Eventbrite to manage tickets. You will need to set up an Eventbrite account and retrieve some credentials to set up the integration.

### Eventbrite Access Token

- visit https://www.eventbrite.com/account-settings/apps
- click 'Create a new app'
- Fill in details and submit
- Copy 'Private token' and set it as `eventbrite_token` in your `Event`

### Eventbrite Event ID

- Create an event if you haven't already
- Go to the page to manage the event
- The URL should be something like `https://www.eventbrite.com/myevent?eid=11111`
- Copy the ID after `eid=` and set it as `eventbrite_id` in your `Event`

### MAILCHIMP_TOKEN

Optionally, if you want members to be added to a Mailchimp account:

- Go to your Mailchimp account page
- Go to 'API keys' under 'Extras'
- Create a key, and then copy to value into your .env as MAILCHIMP_TOKEN

Members will then be added to your first mailchimp list when they confirm their email address.

They will have the tag `member`, and additionally will have the tag `mailchimp-marketing` if they opted in for marketing.

### POSTMARK_API_TOKEN

This app currently uses postmark to send emails. Set your API token using this env variable.

## RECAPTCHA_SITE_KEY & RECAPTCHA_SECRET_KEY

Unfortunately we were getting too many spam registrations, so we're now using Google recaptcha. Register for a v3 account at https://www.google.com/recaptcha/about/

## ENABLE_PLAUSIBLE_IO_ANALYTICS

To give the lightest weight analytics of what goes on with the website, you can use [plausible.io analytics](https://plausible.io), it allows for minimal analytics on a website.

You will need an account with them to be able to use the system, but as this should only run in production, it should be left as false.

Once enabled, it uses the `HOST_NAME` environment variable to populate the `data-domain` for the script.

In your Plausible analytics account, from the logged in page, click `add website`, fill in the data for the site e.g `members.londondecom.org` and you are done! Once the site is live and analytics are enabled it will start recording!

### Running locally

To run this application locally for development, you will need to install:

- ruby (I recommend `rvm`, but you could use `rbenv` or any other technique. The version is specified in `.ruby-version`)
- Postgresql (I use Postgres.app on OSX)

You then need to navigate to the repository's root and run:

- `bundle install` to install dependencies
- `rake db:setup` to setup the database

## Deploy to Heroku

Heroku makes it easy to host Ruby on Rails applications, and this app can be run on a free dino (although you will need to pay $7/month if you want HTTPS)

Before you can deploy this application to Heroku, you will need to get the above credentials from Eventbrite, but instead of putting them into .env, you will be asked for them.

To get started click the button below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Update: we have since moved London Decompression to be hosted with fly.io

## Making admin users

There is a small admin interface to this application. To access it, you need to be logged in as a user with admin privileges. Currently this can only be done over the command line.

First, register as a normal user, and then run a Rails console. If you are working locally, then it is `rails console`. If you want to do this on a Heroku instance, then run `heroku run rails console`. Then run:

```
user = User.find_by(email: 'REPLACE_WITH_EMAIL_ADDRESS')
user.admin = true
user.save!
```

### Codes

For members to be able to buy tickets using their accounts, membership codes need to be imported into Eventbrite, and assigned as access tokens to a hidden ticket.

* Make sure you have set up a ticket type for the event in Eventbrite, and ensure 'Hide this ticket type' is checked for it. This is to ensure that non-members cannot buy this ticket.
* It is possible to have multiple tickets that are hidden in this way.
* Log into the membership app with an admin account, and go to the admin 'Membership Codes' page.
* Ensure you have enough membership codes generated for your need. Be generous (if you have 1,000 people, maybe generate 1,500 codes). This is to ensure we don't run out of access tokens. If not, generate some codes.
* Download the CSV file on that page.
* Update: Eventbrite has restricted uploads to 500 at a time, so use a (CSV splitter)[https://extendsclass.com/csv-splitter.html] to split your file if you have more than 500 codes
* Go to "Manage" for your Eventbrite event. Go to "Tickets" then "Promo Codes".
* Add your first file
* From "Ticket Limit", choose "Limited To", and then input the number of tickets you want each member to be allowed to buy. Our current plan is to allow 1 ticket per member.
* Check "Reveal hidden tickets during checkout"
* Choose "Apply code to" "Only certain hidden tickets", then click "Select" and choose the ticket type you want.
* Click "Save" > Done!

## Contributing

I would be ecstatic if some other people contributed some code. Please do so by forking this repository, making your changes there, and then making a Github Pull Request.

Please make sure that the test suite passes. To run the test suite, simply run `rake` from the repository root. If you are making functional changes, please create or update some rspec specs. I can help with this if you need.

### Using this for other events

Currently references to London Decompression are hardcoded in the code, as well as images, styles etc. So if you want to use this for another event, you will either need to fork this repository and edit them manually, or preferably make a Pull Request that makes it easy to customise these things! Or ask me to do it, and I'll see if I can make the time.
