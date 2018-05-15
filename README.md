# Twttr project
## Louis Loiseau-Billon & Neil Richter

## Installation

1. Run `composer install && npm install` to install the dependencies.
2. Run `cp config/parameters.yml.dist config/parameters.yml` and replace the credentials to connect to the database with yours.
3. Upload the database model onto your server to store the users, and all the informations that need to be stored to run this app.
4. Set a vhost with this app folder for document root to allow the router to work. The homepage must be `http(s)://domain.xzy/`.

### Pages

Register and login on `/register` and `/login`. Your own profile is available at `/profile`. For any other user, the path to their profile will be `/profile/{username}`. Their profile can also be reached by clicking on a twtt's author username, or on the user's profile picture. 

Twtts can be written on any page, from the header. It will open a modal that will twtt asynchronously.

### RT & Favs

Rtwtts and Favs are made asynchronously too, and their state might change whether you have rtwtted/faved the twtt or not.