# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
datafile = Rails.root + "db/data/genres.txt"

File.open(datafile, "r").each_line do |line|
  genre = line.chomp
  Genre.find_or_initialize_by(name: genre) do |g|
    g.name = genre
    g.save!
  end
end

quotesdata = Rails.root+ "db/data/quotes.csv"

CSV.foreach(quotesdata, headers:true) do |row|
  author = row['author']
  quote = row['quotes']

  Quote.find_or_initialize_by(description: quote) do |q|
    q.author = author
    q.description = quote
    q.save!
  end
end
