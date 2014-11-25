# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([{email: 'developer@firebellydesign.com', password: 'changeme'}])
User.create!([{email: 'shannon@firebellyfoundation.org', password: 'changeme'}])

['Home', 'Educational Programs', 'Get Involved', 'Give', 'Success Stories', 'Apply', 'About Us', 'News'].each do |page|
	unless Page.where({title: page}).exists?
		Page.create({title: page, content: "#{page.titleize}!", published: true})
	end
end

PostType.create([{name: 'News'},{name: 'Press'}])
SupporterType.create([{title: 'Sponsors'},{title: 'Partners'},{title: 'Featured'}])
