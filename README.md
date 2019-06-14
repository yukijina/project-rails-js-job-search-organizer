# Job Search Organizer

Flatiron School Ruby on Rails project.

## About this project
User can signup, log in and log out. User can also log in through third party log in(Google).
User can track their job application process in their own checklists.
User can create a company and position, however only admin can edit after they are created.


### Ruby version
- Ruby 2.5.3
- Rails 5.2.3

## Running Locally
Make sure you have Ruby, Bundler.

## Try this app through Heroku
visit: https://rails-job-search-organizer.herokuapp.com/

## Usage
### 1. Check out the repository
`git clone git@github.com:yukijina/project-rails-job-search-organizer.git`

### 2. Go to ththe file
`cd project-rails-job-search-organizer`

### 3. Bundle install
`bundle`

### 4. Create and Set up database
`rails db:migrate`
`rails db:seed`

### 5. Start the Rails server
You can start the rails server using the command given below.  
`rails s`

Now you can visit the app with http://localhost:3000

#### Sing up as Admin
Only admin can edit a company and a position.
If you want to try admin experience, please sign up with admin_code 007.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/yukijina/project-rails-job-search-organizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License
This project is licensed under the MIT License.
