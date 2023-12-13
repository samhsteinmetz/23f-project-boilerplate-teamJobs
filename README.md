# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## Project Overview
Our app, "Get a Job" is a job board integrated with a social media posting functionality designed to help applicants and hiring managers find job matches and create resumes through inputted past work and volunteer experiences, as well as skills and education.

## Database Design
The `db/` folder builds our MySQL database in a MySQL 8 container, and this database is then filled with mock data found in the `db/` folder. Below is the diagram for the database:
<img width="993" alt="image" src="https://github.com/samhsteinmetz/23f-project-boilerplate-teamJobs/assets/120346417/fbabe82e-cf0e-47bc-9208-593d5e96c9af">

## Video Overview Link
https://drive.google.com/file/d/1Fh0rKRPyB9g3cKNZ6bhzfg6if6pqUjIc/view?usp=sharing

  



