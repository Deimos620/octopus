[![Code Climate](https://codeclimate.com/repos/56be813b39477e00600048c9/badges/c7ec1851a27a6a0fe380/gpa.svg)](https://codeclimate.com/repos/56be813b39477e00600048c9/feed)

## Developer Setup

Some basic steps:

- Install the Heroku Toolbelt. Note that we do *not* put the heroku gem into our Gemfile; developers should install the toolbelt directly. Also, OSX users must use `brew install heroku` to install it; do not download the PKG from Heroku (see [this](https://github.com/heroku/toolbelt/issues/53)).
- Install RVM  (Tips for OSX: [here](http://railsapps.github.io/installrubyonrails-mac.html), but only install RVM right now.)

Then do the following. But note:

- This assumes your postgresql version is 9.4
- Feel free to use your own name, but always use a ouroctopus.com email address in your git config - we probably assigned one to you
- Use the password 'octopus' when prompted (it's in the template database.yml)



*Note: See http://stackoverflow.com/questions/16684544/libmagickcore-so-4-cannot-open-shared-object-file-no-such-file-or-directory*

*Why is there a mongodb installation here? Didn't we remove mongodb from the project long ago?*

### Ubuntu Linux


```
sudo ldconfig /usr/local/lib
sudo apt-get install postgresql libpq-dev mongodb nodejs libmagickwand-dev imagemagick

```

### Max OSX

```
brew doctor
brew install postgresql
brew install mongodb
brew install nodejs
```

### Both environments

```
rvm install 2.2.2
git clone git@github.com:e-wing/octopus.git
cd octopus
git remote rename origin github
git config user.name "____"
git config user.email "____@ouroctopus.com"
git config push.default matching
gem install bundler solano mailcatcher
bundle --without production
```
If non-OSX
```
sudo -u postgres psql -c "CREATE USER octopus WITH CREATEDB PASSWORD 'octopus';"
```
If OSX
```
createuser -P -S -R -d octopus
```

For everyone
```
cp config/database.local.yml config/database.yml
rake db:create
rake full_reset:alpha
```

If `rake db:create` doesn't work, then try this:

```
sudo -u postgres createdb -Ooctopus -Eutf8 octopus_development
sudo -u postgres createdb -Ooctopus -Eutf8 octopus_test
```


```
rake full_reset:dev
```


### If you're going to do deployments

If you're going to do deployments then you need to set up the git remotes:

```
git remote add alpha git@heroku.com:oct-alpha.git
git remote add beta git@heroku.com:oct-beta.git
git remote add prod git@heroku.com:oct.git
```

Plus you'll need to add your key:

```
heroku keys:add --remote alpha
heroku keys:add --remote beta
heroku keys:add --remote prod
```


### Windows

No info.


## Development Server


To run the local development server:

```
foreman start
```

Then browse to http://localhost:3000


## Alpha Environment

On Alpha, the seed login is `dev@ouroctopus.com` with password `secretpassword123`.




