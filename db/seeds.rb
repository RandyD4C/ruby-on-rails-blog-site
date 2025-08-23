User.destroy_all
Article.destroy_all
Comment.destroy_all

# Create 10 users
10.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    dob: Faker::Date.birthday(min_age: 12, max_age: 100)
  )

  # Each user creates 3 articles
  3.times do
    article = Article.create!(
      title: Faker::Book.unique.title,
      body: Faker::Lorem.paragraph(sentence_count: 5),
      status: ["public", "private", "archived"].sample,
      user: user
    )

    # Each article writes 3 comments
    3.times do
      Comment.create!(
        commenter: user.name,
        body: Faker::Lorem.paragraph(sentence_count: 2),
        status: ["public", "private", "archived"].sample,
        article: article,
        user: user
      )
    end
  end
end

puts "Seeded #{User.count} users, #{Article.count} articles, and #{Comment.count} comments!"