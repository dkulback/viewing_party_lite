# Viewing Party

### About this Project

Viewing Part Lite is an application in which users can explore movie options and create a viewing party event for themselves and other users of the application.

## DB SCHEMA
![Screen Shot 2022-04-24 at 4 01 32 PM](https://user-images.githubusercontent.com/83717116/164998550-523ad8bf-379f-42e5-b704-76e21d2cdf3b.png)

## INTERVIEWER

* visit heroku deployment of [Viewing Party Here](https://vast-badlands-91206.herokuapp.com/)
  - register a user
  - click discover movies to search or get a top rated list of movies
  - visit a movies show page by clicking on the movie name
  - create a viewing party for the movie and invite other users.
* Configurations
  - REST Rails Application with the exception of the following URLS
	- /discover /dashboard
  - Authentication using Rubys BCRYPT gem
  - Authorization on the controller level by redirecting visitors who are not
    registered
  - CRUD


## Local Setup for any other use

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rake db:{drop,create,migrate}`

## Docker Setup

To run the application using Docker, follow these steps:

1. Make sure you have Docker and Docker Compose installed on your system. You can download Docker [here](https://www.docker.com/get-started) and Docker Compose [here](https://docs.docker.com/compose/install/).

2. Clone the repository to your local machine and navigate to the project root directory.

3. You will need to request an api key through the movies db api [here](https://developers.themoviedb.org/3/getting-started/introduction)

4. run `$ bundle exec figaro install`
> This creates a commented config/application.yml file and adds it to your .gitignore. Add your own configuration to this file and you're done!

5. add api key obtained from the movie db to the application.yml file
   `movie_api_key:<your_api_key>
6. Build the Docker image and start the Docker Compose stack by running the following command:
`$docker-compose up --build`
This command will build the Docker image and start the web and db services defined in the docker-compose.yml file.

7. Once the Docker Compose stack is running, you can access the application by navigating to http://localhost:3000 in your web browser.

8. When you're finished using the application, you can stop the Docker Compose stack by running the following command:
`$docker-compose down`
This command will stop and remove the containers, networks, and volumes created by the Docker Compose stack.

Note: If you make any changes to the application code or configuration files, you will need to rebuild the Docker image and restart the Docker Compose stack for the changes to take effect. You can do this by running the docker-compose up --build command again.


## Versions

- Ruby 2.7.2

- Rails 5.2.6

Example wireframes to follow are found [here](https://backend.turing.io/module3/projects/viewing_party_lite/wireframes)
