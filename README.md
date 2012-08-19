# misterzip

misterzip provides a simple web API for sending email, e.g. for use with
a site hosted on GitHub Pages.

# Setup

misterzip is designed to run on Heroku and depends on the Sendgrid
add-on. Besides the Sendgrid configuration variables, misterzip needs
`MISTERZIP_RECIPIENT` set to the recipient email address.

# API endpoint

The API is namespaced to /misterzip. For example, a letter delivery
request is accessible at `/misterzip/letter`.

# Letters API

## Deliver a letter

    POST /letter

### Input

```json
{
    "subject": "Greetings.",
    "message": "Hello, world!",
    "email": "dennis.ritchie@example.com",
    "name": "Dennis Ritchie",
}
```

### Response

```json
{
    "subject": "Greetings.",
    "message": "Hello, world!",
    "email": "dennis.ritchie@example.com",
    "name": "Dennis Ritchie",
}
```

# TODO

- reCAPTCHA support


