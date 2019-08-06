# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

User.destroy_all
Company.destroy_all
Position.destroy_all

#Company
csv_text = File.read(Rails.root.join('lib', 'seeds', 'companies.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
csv.each do |row|
  c = Company.new
  c.name = row['name']
  c.url = row['url']
  c.description = row['description']
  c.save
end

puts "there are now #{Company.count} rows in companies table"

#Position
csv_text = File.read(Rails.root.join('lib', 'seeds', 'positions.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')


csv.each do |row|
  puts row.to_hash
  p = Position.new
  puts "#{p.company_id = Company.find(row['company_id'].to_i)}"
  p.title = row['title']
  p.description = row['description']
  p.salary = row['salary']
  p.full_time = row['full_time'].downcase
  p.company_id = row['company_id'].to_i
  p.save!
  puts "#{p.title}, #{p.full_time}, #{p.company_id} saved!"
end

puts "#{Position.count} created"

#User
u1 = User.create(username: "Peach", email: "peach@test.com", password: "test", admin: true, admin_code: 007)
u2 = User.create(username: "Tom", email: "tom@test.com", password: "test", admin: false, admin_code: 999)
u3 = User.create(username: "Paul", email: "paul@test.com", password: "test", admin: false, admin_code: 999)
