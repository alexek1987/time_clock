HOW TO RUN THIS APP
-Rails 6.0.3.2


-Install dependecies and create DB

bundle install
rails db:create
rails db:migrate

-Create a user and job

rails c
user = User.create(email: 'mike@brown.com', first_name: 'Mike', password: 'password')
job = Job.create(position: 'Barista', user: user)
shift = Job.create(user: user, job: job, clock_in: Time.now)


- Adding API-key/token

From the console check the user token.

On line 58 in script.js
'X-User-Token': 'TOKEN GOES HERE'
Replace the dummy test with the user token.


- Launch the server to clock in and out :)


