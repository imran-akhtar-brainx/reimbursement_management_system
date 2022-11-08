# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: :"imran.akhtar@mailinator.com", password: :"qwerty", emp_id: :"0137", name: :"Imran Akhtae", phone: 03340053, department: :"Ror")
User.create(email: :"soban.akbar@mailinator.com", password: :"qwerty", emp_id: :"0222", name: :"Soban Akbar", phone: 03340053, department: :"Accounts")
User.create(email: :"tahir@mailinator.com", password: :"qwerty", emp_id: :"01131", name: :"Tahir", phone: 03340053, department: :"Ror")
User.create(email: :"soban.akram@mailinator.com", password: :"qwerty", emp_id: :"01131", name: :"Soban Akrm", phone: 03340053, department: :"Ror")

Role.create(_type: :software_engineer , medical_allowance: 1500 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)
Role.create(_type: :project_manager , medical_allowance: 15000 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)
Role.create(_type: :admin , medical_allowance: 15000 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)
Role.create(_type: :accountant , medical_allowance: 15000 , travel_allowance: 1000 , fitness_allowance: 32330, dinner_allowance: 3000)


Form.create(_type: :"medical", data: {consultant: "Dr.imran", patient: "umar", description: "Throat infection", fees: "2000", total: "2000"})
Form.create(_type: :"working", data: {"reporting_manager":"", date:"" ,day:"", reason_of_working:"", nature_of_holiday:"",amount:""})
Form.create(_type: :"expense", data: {project_name: "..", details: "", amount: ""})
Form.create(_type: :"general", data: {description: "", amount: ""})

Submission.create()
Submission.where(form_id: 1).update(data: {"name_of_patient"=>"fsdf", "relationship_with_employee"=>"sdf", "description"=>"sdf", "expense_in_rs"=>"sdf"})
Submission.where(form_id: 2).update(data: {date: "25 july 2020", day: "monday", reason: "client need", nature: "weekend"})
Submission.where(created_at: Time.new(2022,10,15)..Time.new(2022,10,20))
Submission.where(created_at: (Date.parse('2022-10-15')..Date.parse('2022-10-20')))

