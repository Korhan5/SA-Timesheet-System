# SA Timesheet System
## CS445 - Software Engineering
### Matthew Damiata, Korhan Citlak, Ethan Breban, Benjamin Keurian, Joshua Szachar

The current timesheet system that the SA uses has many faults in their UI, permissions, ease of use, and has an inability for users to edit previous responses (adding hours). Our goal is to create a new timesheet system without the previous faults for SA workers to clock in and clock out their hours to get paid accurately.

### Development Build
1. Clone the repo
2. Run `$ bundle install --without production`
3. Create an [OAuth App](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app) on GitHub
4. Run `$ bundle exec figaro install`
5. Edit `config/application.yml` to include the GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET
6. Run `$ rake db:migrate` and `$ rake db:migrate RAILS_ENV=test`
7. Run `$ rails s -b 0.0.0.0` and visit the local server

### Production Build
1. Run `$ heroku login -i` and `$ heroku create`
2. Then push to GitHub with `$ git push heroku main`
3. Create a new OAuth app with links/callbacks to the new Heroku production link
3. Add new OAuth keys to Heroku with `$ heroku config:set GITHUB_CLIENT_ID=xxxxxx` for GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET
4. Visit the website with the link Heroku provides
