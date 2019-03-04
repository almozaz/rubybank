# README

* Rails version: 5.1.4

* Database: Sqlite3



> $ rails db:create db:migrate db:seed


* To create new users

> $ rails console
> $ Admin.create_user(username, password)

* Transfer money from admin to user
Admin.create_user(username, password)


> $ Admin.admin_transfer(amount, user)
