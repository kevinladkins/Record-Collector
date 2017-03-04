# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database --
      See Migrations -- tables built for users, records, artists, and labels, as well as join table for record_users

- [x] Include more than one model class (list of model class names e.g. User, Post, Category) --
      Models for each of the aformentioned tables, as well as "slugify" module for converting model :name attributes to URL

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) --
      Artists, Users, and Labels have many Records, Records have many Users, Users have many Artists through Records, etc.

- [x] Include user accounts --
      User accounts with encrypted passwords included

- [x] Ensure that users can't modify content created by other users --
      Attempts to access another user's content result in redirect to logged-in user's Index page

- [x] Include user input validations --
      All view routes verify user is valid and logged in before displaying content

- [ ] Display validation failures to user with error message (example form URL e.g. /posts/new)

- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
