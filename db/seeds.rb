# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(email: :"imran.akhtar@gmail.com", password: :"qwerty", emp_id: :"0137", name: :"Imran Akhtae", phone: 03340053, department: :"Ror" )
Role.create(_type: :software_engineer , medical_allowance: 1500 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)