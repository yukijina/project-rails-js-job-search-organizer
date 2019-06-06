# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Company.destroy_all
Position.destroy_all


#User
u1 = User.create(username: "Peach", email: "peach@test.com", password: "test", admin: true, admin_code: 007)
u2 = User.create(username: "Julie", email: "julie@test.com", password: "test", admin: false, admin_code: 999)
u3 = User.create(username: "Paul", email: "paul@test.com", password: "test", admin: false, admin_code: 999)

#Company
c1 = Company.create(name: "Canvas", url: "https://drivecanvas.com/")
c2 = Company.create(name: "OpenAI", url: "https://openai.com/")
c3 = Company.create(name: "Apple", url: "https://www.apple.com/")
c4 = Company.create(name: "Walmart", url: "https://www.walmart.com/")
c5 = Company.create(name: "Open Table", url: "https://www.opentable.com/")

#Position
p1 = c1.positions.create(title: "Software Engineer", description: "You’ve got 5+ years of experience writing backend code", salary: 125000, full_time: true)
p2 = c1.positions.create(title: "Product Designer", description: "Experience designing digital products and systems", salary: 125000, full_time: true)
p3 = c1.positions.create(title: "Operations Associate", description: "Flexibility with your schedule and excellent attention to details", salary: 55000, full_time: true)
p4 = c2.positions.create(title: "Machine Learning Engineer", description: "2+ years of ML work experience", salary: 80000, full_time: true)
p5 = c2.positions.create(title: "IT Specialist", description: "nsuring a smooth experience for employees’ IT onboarding", salary: 60000, full_time: true)
p6 = c3.positions.create(title: "Siri Engineer", description: "3+ years of software engineering experience", salary: 80000, full_time: true)
p7 = c3.positions.create(title: "UX/UI Design Lead", description: "at least 8+ years experience as a UX/UI designer", salary: 13000, full_time: true)
p8 = c4.positions.create(title: "Business Development & Strategy Analyst", description: "2+ years of investment banking or management consulting experience", salary: 60000, full_time: true)
p9 = c4.positions.create(title: "Executive Assistant", description: "Supports operations of assigned area", salary: 30000, full_time: false)
p10 = c5.positions.create(title: "Android Engineering Manager", description: "Lead a multi-talented team of Android engineers", salary: 80000, full_time: true)
p11 = c5.positions.create(title: "Software Engineer", description: "5+ years in software engineering", salary: 50000, full_time: false)
