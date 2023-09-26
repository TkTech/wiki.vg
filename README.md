# wiki.vg

This is the repository that builds the https://wiki.vg website. It'

## Deploying

The website is automatically deployed when a commit is pushed to the `master` branch.

When deploying to a new dokku install, you'll need to set some environment variables
and set up a database. In practice, the environment for https://wiki.vg is set up by
the maintainer's ansible scripts, but here's how to do it manually in case they get
hit by a bus:

```sh
# Give it a domain name.
dokku domains:set wiki wiki.vg
# Enable letsencrypt to get a SSL certificate.
dokku letsencrypt:enable wiki
# Set up a new database.
dokku mariadb:create wiki
# Link the database to the app to populate the DATABASE_URL environment variable.
dokku mariadb:link wiki wiki
# Optionally import a database dump
dokku mariadb:import wiki < wiki.sql
# Set up the environment variables.
dokku config:set --no-restart wiki MW_SMTP_HOST=smtp.mailgun.org
dokku config:set --no-restart wiki MW_SMTP_PORT=587
dokku config:set --no-restart wiki MW_SMTP_IDHOST=wiki.vg
dokku config:set --no-restart wiki MW_SMTP_USERNAME=wiki.vg
dokku config:set --no-restart wiki MW_SMTP_PASSWORD=wiki.vg
dokku config:set --no-restart wiki MW_SECRET_KEY=<long random gibberish>
dokku config:set wiki MW_UPGRADE_KEY=<long random gibberish>
# Persistent image uploads
dokku storage:ensure-directory --chown false wiki_images
dokku storage:mount wiki /var/lib/dokku/data/storage/wiki_images:/var/www/html/images
```

How you do backups is up to you. The `.github/workflows/deploy.yml` file in this repository
contains an example of automatic deploys.