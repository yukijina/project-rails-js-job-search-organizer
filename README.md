# Job Search Organizer

Flatiron School Ruby on Rails with JavaScript Project.

## About this project
A user can signup, log in and log out. A user can also log in through a third party log in(Google).
Users can track their job application processes in their own checklists.
Users can create a company and position, however only admin can edit after they are created.


### Ruby version
- Ruby 2.3.3
- Rails 5.2.3

## Running Locally
Make sure you have Ruby, Bundler.

## Usage
### 1. Check out the repository
`git clone git@github.com:yukijina/project-rails-js-job-search-organizer.git`

### 2. Go to the file
`cd project-rails-js-job-search-organizer`

### 3. Bundle install
`bundle`

### 4. Create and Set up database
`rails db:migrate`
`rails db:seed`

### 5. Start the Rails server
You can start the rails server using the command given below.  
`rails s`

Now you can visit the app with http://localhost:3000

### You can also visit the app through Heroku
visit: https://rails-job-search-organizer.herokuapp.com/

#### Sing up as Admin
Only admin can edit a company and a position.
If you want to try admin experience, please sign up with admin_code 007.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/yukijina/project-rails-js-job-search-organizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License
This project is licensed under the MIT License.
