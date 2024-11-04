# LAMP Server via Docker
This repo is allowing you to create your LAMP server via docker.

### Versions 
- PHP 8.2.25
- Composer 2.8.2
- npm 9.2
- Mysql 9.1
- Phpmyadmin 5.2.1

### Folder Structure
`/public` folder is where the website lives

`/dbdata` folder holds the database content

### Database Credentials
- Database: `testdb` 
- DB username: `testusr` 
- DB Password: `password` 
- DB Host: `db`

### How to run
Run the following command:
`docker compose -f docker-composer.yml up`

Visit `http://localhost:8100` to view the site

Visit `http://localhost:8102` for Phpmyadmin
