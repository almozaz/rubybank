# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create_user('test1', 'test1')
Admin.create_user('test2', 'test2')
Admin.create_user('test3', 'test3')

User.find(1).account.update_column(:balance, 50)
User.find(3).account.update_column(:balance, 150)
User.find(3).account.update_column(:balance, 75)
