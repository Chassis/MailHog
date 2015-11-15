# MailHog
A Chassis extension to install and configure
[MailHog](https://github.com/mailhog/MailHog) on your server.

With this extension, MailHog will act as a fake mail server, showing your
email in the browser rather than sending it to the email address. This is great
for testing where you don't want the emails to actually be sent, but still need
access to them.

<img src="http://i.imgur.com/5CqsgAI.png" />

## Usage
1. Add this extension to your extensions directory
2. Run `vagrant provision`
3. Go to http://vagrant.local:8025/ to view your MailHog inbox.

That's it!

If you need to debug any problems, MailHog outputs logs to
`/var/log/mailhog/mailhog.log`

## Important Notes
* This extension sets up MailHog as the default mailer for PHP; note that
  all email sent via `mail`, including WordPress' built-in `wp_mail`, will be
  sent to MailHog.

* MailHog's database of emails is stored in memory, and will be reset when
  you halt the Vagrant instance.
