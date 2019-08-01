# MailHog
A Chassis extension to install and configure
[MailHog](https://github.com/mailhog/MailHog) on your server.

With this extension, MailHog will act as a fake mail server, showing your
email in the browser rather than sending it to the email address. This is great
for testing where you don't want the emails to actually be sent, but still need
access to them.

<img src="http://i.imgur.com/5CqsgAI.png" />

## Global Installation

We recommend [installing this extension globally](http://docs.chassis.io/en/latest/extend/#globally-installing-extensions) to make it available on every Chassis box.

```
git clone https://github.com/Chassis/MailHog ~/.chassis/extensions/mailhog
```
## Project Installation
1. Add this extension to your extensions directory `git clone git@github.com:Chassis/MailHog.git extensions/mailhog` or alternatively add the following to one of your [`.yaml`](https://github.com/Chassis/Chassis/blob/master/config.yaml) files:
   ```
   extensions:
     - chassis/mailhog
   ```
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
