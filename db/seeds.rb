# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

moods = [
  {name: 'Happy'},
  {name: 'Sad'},
  {name: 'Funny'},
  {name: 'Serious'}
]
moods.each do |mood|
  Mood.find_or_create_by(mood)
end

genres = [
  {name: 'Romantic'},
  {name: 'Comedy'},
  {name: 'Drama'},
  {name: 'Tragedy'},
  {name: 'Satire'},
  {name: 'Horror'}
]
genres.each do |genre|
  Genre.find_or_create_by(genre)
end

10.times{
  User.create(
    first_name: FAKER::Name.first_name, 
    last_name: FAKER::Name.last_name, 
    username: Faker::Internet.username, 
    email: Faker::Internet.email, 
    password: Faker::Internet.password(8,8)
  )
}

User.all.each do |user|
  UserGenre.create(user_id: user.id, genre_id: Genre.all.to_a.sample.id)
end

