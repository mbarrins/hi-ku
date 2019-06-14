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

25.times{
  User.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    username: Faker::Internet.username, 
    email: Faker::Internet.email, 
    password: Faker::Internet.password(8,8)
  )
}

User.all.each do |user|
  UserGenre.create(user_id: user.id, genre_id: Genre.all.to_a.sample.id)
end

200.times do
  quote = Faker::Quote.most_interesting_man_in_the_world.split(" ")

  Poem.create(
  user_id: User.all.to_a.sample.id,
  genre_id: Genre.all.to_a.sample.id,
  mood_id: Mood.all.to_a.sample.id,
  title: "#{Faker::Verb.past_participle.titlecase} #{Faker::Verb.ing_form.titlecase}",
  line_1: quote[0...(quote.length/3)].join(" "),
  line_2: quote[(quote.length/3)...(-quote.length/3)].join(" "),
  line_3: quote[(-quote.length/3)..-1].join(" ")
  )
end

500.times do
  user_id = User.all.to_a.sample.id
  poem_id = Poem.all.select{|poem| poem.user_id != user_id}.sample.id
  Like.create(user_id: user_id, poem_id:poem_id)
end

300.times do
  user_id = User.all.to_a.sample.id
  poem_id = Poem.all.select{|poem| poem.user_id != user_id}.sample.id
  Comment.create(user_id: user_id, poem_id:poem_id, content: Faker::Quote.famous_last_words)
end