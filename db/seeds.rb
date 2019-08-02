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
u4 = User.create(username: "Sara", email: "sara@test.com", password: "test", admin: false, admin_code: 999)

#Company
c1 = Company.create(name: "Canvas", url: "https://drivecanvas.com/", description: "As a part of the Ford family, Canvas has the DNA of a startup with the resources and expertise of a global brand. Together, we are working on creating a true alternative to car ownership for today’s customer, while we continue to look towards the future. Canvas is based in downtown San Francisco, and we currently serve the greater Bay Area and Los Angeles.")
c2 = Company.create(name: "Yelp", url: "https://www.yelp.com/careers/job-openings", description: "Yelp is a business directory service and crowd-sourced review forum, and a public company of the same name that is headquartered in San Francisco, California. The company develops, hosts and markets the Yelp.com website and the Yelp mobile app, which publish crowd-sourced reviews about businesses. It also operates an online reservation service called Yelp Reservations.")
c3 = Company.create(name: "Apple", url: "https://www.apple.com/", description: "We’re a diverse collective of thinkers and doers, continuously reimagining our products and practices to help people do what they love in new ways. That innovation is inspired by a shared commitment to great work — and to each other. Because learning from the people here means we’re learning from the best.")
c4 = Company.create(name: "Walmart", url: "https://www.walmart.com/", description: "What started small, with a single discount store and the simple idea of selling more for less, has grown over the last 50 years into the largest retailer in the world. Each week, nearly 265 million customers and members visit our more than 11,200 stores under 55 banners in 27 countries and eCommerce websites in 10 countries. With fiscal year 2018 revenue of $500.3 billion, Walmart employs over 2.2 million associates worldwide. Walmart continues to be a leader in sustainability, corporate philanthropy and employment opportunity. It’s all part of our unwavering commitment to creating opportunities and bringing value to customers and communities around the world.")
c5 = Company.create(name: "Open Table", url: "https://www.opentable.com/", description: "We love what can happen around the restaurant table. And since 1998 we’ve been committed to empowering that experience. From helping restaurants of all sizes thrive, to enabling diners to find and book the perfect table for every occasion, our story is one of human connection—among diners and restaurants, and between restaurants and their communities.")
c6 = Company.create(name: "Uber", url: "https://www.uber.com/us/en/careers/", description: "Good things happen when people can move, whether across town or towards their dreams. Opportunities appear, open up, become reality. What started as a way to tap a button to get a ride has led to billions of moments of human connection as people around the world go all kinds of places in all kinds of ways with the help of our technology.")
c7 = Company.create(name: "Tesla", url: "https://www.tesla.com/careers", description: "Tesla was founded in 2003 by a group of engineers who wanted to prove that people didn’t need to compromise to drive electric – that electric vehicles can be better, quicker and more fun to drive than gasoline cars. Today, Tesla builds not only all-electric vehicles but also infinitely scalable clean energy generation and storage products. Tesla believes the faster the world stops relying on fossil fuels and moves towards a zero-emission future, the better.")

#Position
p1 = c1.positions.create(title: "Software Engineer", description: "You’ve got 5+ years of experience writing backend code", salary: 125000, full_time: true)
p2 = c1.positions.create(title: "Product Designer", description: "Experience designing digital products and systems", salary: 125000, full_time: true)
p3 = c1.positions.create(title: "Operations Associate", description: "Flexibility with your schedule and excellent attention to details", salary: 55000, full_time: true)
p4 = c2.positions.create(title: "Machine Learning Engineer", description: "2+ years of ML work experience", salary: 80000, full_time: true)
p5 = c2.positions.create(title: "Software Engineer(Android)", description: "Expertise in Java or other mobile languages", salary: 70000, full_time: true)
p6 = c3.positions.create(title: "Siri Engineer", description: "3+ years of software engineering experience", salary: 80000, full_time: true)
p7 = c3.positions.create(title: "UX/UI Design Lead", description: "at least 8+ years experience as a UX/UI designer", salary: 13000, full_time: true)
p8 = c4.positions.create(title: "Business Development & Strategy Analyst", description: "2+ years of investment banking or management consulting experience", salary: 60000, full_time: true)
p9 = c4.positions.create(title: "Executive Assistant", description: "Supports operations of assigned area", salary: 30000, full_time: false)
p10 = c5.positions.create(title: "Android Engineering Manager", description: "Lead a multi-talented team of Android engineers", salary: 80000, full_time: true)
p11 = c5.positions.create(title: "Software Engineer", description: "5+ years in software engineering", salary: 50000, full_time: false)
p12 = c6.positions.create(title: "Program Manager", description: "Minimum of 5 years hands-on experience project managing", salary: 80000, full_time: true)
p12 = c6.positions.create(title: "Frontend Engineer", description: "Deep understanding of UI framework and choices and experience", salary: 70000, full_time: true)
p13 = c6.positions.create(title: "Hardware Technical Program Manager", description: "Minimum of 7 years experience as a program / project manager driving Hardware ", salary: 90000, full_time: true)
p14 = c7.positions.create(title: "Intern Material Engineering", description: "Fundamental knowledge of materials science and physical metallurgy is required.", salary: 30000, full_time: false)
p15 = c7.positions.create(title: "Full Stack Developer", description: "Collaborate with a dynamic team utilizing technologies ranging from React and Python", salary: 70000, full_time: true)
p16 = c7.positions.create(title: "Product Security Engineer", description: "Security expertise in one or more of: C, C++, x86, ARM, CAN.", salary: 70000, full_time: true)
