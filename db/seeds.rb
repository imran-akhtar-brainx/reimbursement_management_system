# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Form.create(_type: :"medical", data: {consultant: "Dr.imran", patient: "umar", description: "Throat infection", fees: "2000", total: "2000"})
User.create(email: :"imran.akhtar@gmail.com", password: :"qwerty", emp_id: :"0137", name: :"Imran Akhtae", phone: 03340053, department: :"Ror")

User.create(email: :"umair@gmail.com", password: :"qwerty", emp_id: :"0111", name: :"Umair", phone: 03340053, department: :"Ror")

Role.create(_type: :software_engineer , medical_allowance: 1500 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)

Role.create(_type: :project_manager , medical_allowance: 15000 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)

User.create(email: :"soban.akbar@gmail.com", password: :"qwerty", emp_id: :"0222", name: :"Soban Akbar", phone: 03340053, department: :"Accounts")

Role.create(_type: :accountant , medical_allowance: 15000 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)
Form.create(_type: :"working", data: {"reporting_manager":"", date:"" ,day:"", reason_of_working:"", nature_of_holiday:"",amount:""})
Form.create(_type: :"expense", data: {project_name: "..", details: "..", amount: "..."})
Form.create(_type: :"general", data: {description: "", amount: ""})

Submission.create()
Submission.where(form_id: 1).update(data: {"name_of_patient"=>"fsdf", "relationship_with_employee"=>"sdf", "description"=>"sdf", "expense_in_rs"=>"sdf"})
Submission.where(form_id: 2).update(data: {date: "25 july 2020", day: "monday", reason: "client need", nature: "weekend"})
Submission.where(created_at: Time.new(2022,10,15)..Time.new(2022,10,20))
Submission.where(created_at: (Date.parse('2022-10-15')..Date.parse('2022-10-20')))


#single
Submission.take

#multiple
Submission.all.each do |submission|
  puts submission.status
end

Submission.find_each(batch_size: 20) do |submission|
  puts submission.status
end

#find in batch
Submission.find_in_batches(batch_size: 10) do |submission|
end


#condition
Submission.where(status: "pending")

#overriding
Submission.where('id > 10').limit(20).order('id desc').unscope(:order)

Submission.select(:status, :data).reselect(:created_at)

#Locking
c1 = User.find(1)
c2 = User.find(1)
c1.name = "Sandra"
c1.save
c2.name = "Michael"
c2.save


#eager loading
users = User.limit(5)
users.each do |user|
  puts user.role
end

users = User.includes(:roles).limit(5)
users.each do |user|
  puts user.roles
end

#enums
Role.first.admin?
Role.first.software_engineer?


