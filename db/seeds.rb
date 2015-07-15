Book.destroy_all
Author.destroy_all
Category.destroy_all

categories = ["Art & Photography", "Biography", "Business, Finance & Law",
  "Children's Books", "Computing", "Crafts and Hobbies", "Crime & Thriller",
  "Dictionaries & Languages", "Entertainment", "Fantasy", "Fiction",
  "Food & Drink", "Health", "History & Archaeology", "Home & Garden", "Humour",
  "Medical", "Mind, Body & Spirit", "Natural History", "Personal Development",
  "Poetry & Drama", "Reference", "Religion", "Romance", "Science & Geography",
  "Science Fiction", "Society & Social Sciences", "Sport", "Stationery",
  "Teaching Resources & Education", "Technology & Engineering", "Transport",
  "Travel & Holiday Guides"]

categories.each do |category|
  Category.create!(name: category)
end

puts "Created #{Category.count} categories."

Book.create!([{
  title: "The Hobbit: The Enchanting Prelude to the Lord of the Rings",
  description: "Whisked away from his comfortable, unambitious life in his hobbit-hole in Bag End by Gandalf the wizard and a company of dwarves, Bilbo Baggins finds himself caught up in a plot to raid the treasure hoard of Smaug the Magnificent, a large and very dangerous dragon. Although quite reluctant to take part in this quest, Bilbo surprises even himself by his resourcefulness and his skill as a burglar! Written for J.R.R. Tolkien's own children, The Hobbit met with instant success when published in 1937. ",
  price: 8.39,
  stock: 20,
  category_id: 10,
  author: Author.create!(first_name: "J. R. R.", last_name: "Tolkien")
},
{
  title: "The Martian",
  description: "The best-seller behind the major film from Ridley Scott, starring Matt Damon and Jessica Chastain. I'm stranded on Mars. I have no way to communicate with Earth. I'm in a Habitat designed to last 31 days. If the Oxygenator breaks down, I'll suffocate. If the Water Reclaimer breaks down, I'll die of thirst. If the Hab breaches, I'll just kind of explode. If none of those things happen, I'll eventually run out of food and starve to death. So yeah. I'm screwed.",
  price: 6.50,
  stock: 11.25,
  category_id: 11,
  author: Author.create!(first_name: "Andy", last_name: "Weir")
},
{
  title: "Unbroken",
  description: "The incredible true story of Louis Zamperini, now a major motion picture directed by Angelina Jolie. THE INTERNATIONAL NUMBER ONE BESTSELLER In 1943 a bomber crashes into the Pacific Ocean. Against all odds, one young lieutenant survives. Louise Zamperini had already transformed himself from child delinquent to prodigious athlete, running in the Berlin Olympics. Now he must embark on one of the Second World War's most extraordinary odysseys.",
  price: 12.73,
  stock: 17,
  category_id: 2,
  author: Author.create!(first_name: "Laura", last_name: "Hillenbrand")
},
{
  title: "Learn Ruby on Rails for Web Development: Learn Rails the Fast and Easy Way!",
  description: "Learning Ruby on Rails has never been this fast and easy, or fun! Veteran Codemy.com programmer John Elder walks you step by step through the ins and outs of Rails for Web Development. Written for the absolute beginner, you don't need any programming experience to dive in and get started with this book. Follow along as John builds a Pinterest-style website from start to finish that allows people to sign up, log in and out, edit their profile, upload images to the database and style those images on the screen. By the end, you'll be well on your way to becoming a professional Ruby on Rails coder!",
  price: 15.35,
  stock: 12,
  category_id: 5,
  author: Author.create!(first_name: "John", last_name: "Elder")
},
{
  title: "Ruby on Rails Tutorial",
  description: "Learning Ruby on Rails has never been this fast and easy, or fun! Veteran Codemy.com programmer John Elder walks you step by step through the ins and outs of Rails for Web Development. Written for the absolute beginner, you don't need any programming experience to dive in and get started with this book. Follow along as John builds a Pinterest-style website from start to finish that allows people to sign up, log in and out, edit their profile, upload images to the database and style those images on the screen. By the end, you'll be well on your way to becoming a professional Ruby on Rails coder!",
  price: 12.25,
  stock: 4,
  category_id: 5,
  author: Author.create!(first_name: "Michael", last_name: "Hartl")
}])

puts "Created #{Book.count} books."
