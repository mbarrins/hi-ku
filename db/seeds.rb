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

100.times do
  quote = Faker::Quote.most_interesting_man_in_the_world.split(" ")
  len = quote.length
  len_line1 = len % 3 == 0 ? len/3 : (len/3)+1
  line1 = quote[0...len_line1]
  len = len - len_line1
  len_line2 = len % 2 == 0 ? len/2 : (len/2)+1
  line2 = quote[len_line1...(len_line1+len_line2)]
  line3 = quote[(len_line1+len_line2)..-1]

  Poem.create(
  user_id: User.all.to_a.sample.id,
  genre_id: Genre.all.to_a.sample.id,
  mood_id: Mood.all.to_a.sample.id,
  title: "#{Faker::Verb.past_participle.titlecase} #{Faker::Verb.ing_form.titlecase} #{Faker::Verb.base}",
  line_1: line1.join(" "),
  line_2: line2.join(" "),
  line_3: line3.join(" ")
  )
end

250.times do
  user_id = User.all.to_a.sample.id
  poem_id = Poem.all.select{|poem| poem.user_id != user_id}.sample.id
  Like.create(user_id: user_id, poem_id:poem_id)
end

100.times do
  user_id = User.all.to_a.sample.id
  poem_id = Poem.all.select{|poem| poem.user_id != user_id}.sample.id
  Comment.create(user_id: user_id, poem_id:poem_id, content: Faker::Quote.famous_last_words)
end