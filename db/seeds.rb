Book.destroy_all
Author.destroy_all
Category.destroy_all
Delivery.destroy_all

categories = ["Art & Photography", "Biography", "Business, Finance & Law",
  "Children's Books", "Computing", "Crafts and Hobbies", "Crime & Thriller",
  "Dictionaries & Languages", "Entertainment", "Fantasy", "Fiction",
  "Food & Drink", "Health", "History & Archaeology", "Medical",
  "Natural History", "Poetry & Drama", "Reference", "Romance",
  "Science & Geography", "Science Fiction", "Society & Social Sciences",
  "Sport", "Technology & Engineering"]

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
  author: Author.create!(first_name: "J. R. R.", last_name: "Tolkien"),
  cover: Rails.root.join("db/images/hobbit.jpg").open
},
{
  title: "The Martian",
  description: "The best-seller behind the major film from Ridley Scott, starring Matt Damon and Jessica Chastain. I'm stranded on Mars. I have no way to communicate with Earth. I'm in a Habitat designed to last 31 days. If the Oxygenator breaks down, I'll suffocate. If the Water Reclaimer breaks down, I'll die of thirst. If the Hab breaches, I'll just kind of explode. If none of those things happen, I'll eventually run out of food and starve to death. So yeah. I'm screwed.",
  price: 6.50,
  stock: 11.25,
  category_id: 11,
  author: Author.create!(first_name: "Andy", last_name: "Weir"),
  cover: Rails.root.join("db/images/martian.jpg").open
},
{
  title: "Unbroken",
  description: "The incredible true story of Louis Zamperini, now a major motion picture directed by Angelina Jolie. THE INTERNATIONAL NUMBER ONE BESTSELLER In 1943 a bomber crashes into the Pacific Ocean. Against all odds, one young lieutenant survives. Louise Zamperini had already transformed himself from child delinquent to prodigious athlete, running in the Berlin Olympics. Now he must embark on one of the Second World War's most extraordinary odysseys.",
  price: 12.73,
  stock: 17,
  category_id: 2,
  author: Author.create!(first_name: "Laura", last_name: "Hillenbrand"),
  cover: Rails.root.join("db/images/unbroken.jpg").open
},
{
  title: "Learn Ruby on Rails for Web Development: Learn Rails the Fast and Easy Way!",
  description: "Learning Ruby on Rails has never been this fast and easy, or fun! Veteran Codemy.com programmer John Elder walks you step by step through the ins and outs of Rails for Web Development. Written for the absolute beginner, you don't need any programming experience to dive in and get started with this book. Follow along as John builds a Pinterest-style website from start to finish that allows people to sign up, log in and out, edit their profile, upload images to the database and style those images on the screen. By the end, you'll be well on your way to becoming a professional Ruby on Rails coder!",
  price: 15.35,
  stock: 12,
  category_id: 5,
  author: Author.create!(first_name: "John", last_name: "Elder"),
  cover: Rails.root.join("db/images/ror_webdev.jpg").open
},
{
  title: "Ruby on Rails Tutorial",
  description: "Learning Ruby on Rails has never been this fast and easy, or fun! Veteran Codemy.com programmer John Elder walks you step by step through the ins and outs of Rails for Web Development. Written for the absolute beginner, you don't need any programming experience to dive in and get started with this book. Follow along as John builds a Pinterest-style website from start to finish that allows people to sign up, log in and out, edit their profile, upload images to the database and style those images on the screen. By the end, you'll be well on your way to becoming a professional Ruby on Rails coder!",
  price: 12.25,
  stock: 4,
  category_id: 5,
  author: Author.create!(first_name: "Michael", last_name: "Hartl"),
  cover: Rails.root.join("db/images/ror_tutorial.jpg").open
},
{
  title: "Alfred Hitchcock",
  description: "Alfred Hitchcock was a strange child. Fat, lonely, burning with fear and ambition, his childhood was an isolated one, scented with fish from his father's shop. Afraid to leave his bedroom, he would plan great voyages, using railway timetables to plot an exact imaginary route across Europe. So how did this fearful figure become the one of the most respected film directors of the twentieth century? As an adult, Hitch rigorously controlled the press' portrait of himself, drawing certain carefully selected childhood anecdotes into full focus and blurring all others out.",
  price: 16.66,
  stock: 4,
  category_id: 2,
  author: Author.create!(first_name: "Peter", last_name: "Ackroyd"),
  cover: Rails.root.join("db/images/alfred.jpg").open
},
{
  title: "All the Light We Cannot See",
  description: "Alfred Hitchcock was a strange child. Fat, lonely, burning with fear and ambition, his childhood was an isolated one, scented with fish from his father's shop. Afraid to leave his bedroom, he would plan great voyages, using railway timetables to plot an exact imaginary route across Europe. So how did this fearful figure become the one of the most respected film directors of the twentieth century? As an adult, Hitch rigorously controlled the press' portrait of himself, drawing certain carefully selected childhood anecdotes into full focus and blurring all others out.",
  price: 13.08,
  stock: 6,
  category_id: 12,
  author: Author.create!(first_name: "Anthony", last_name: "Doerr"),
  cover: Rails.root.join("db/images/light.jpg").open
},
{
  title: "The Forgiven",
  description: "\"A modern Graham Greene\". (Sunday Times). David and Jo Henniger are on their way to a party at their old friends' home, deep in the Moroccan desert. But as a groggy David navigates the dark desert roads, two young men spring from the roadside, the car swerves and collides with one of the boys...Meanwhile, festivities at the house are in full flow. ",
  price: 11.95,
  stock: 3,
  category_id: 11,
  author: Author.create!(first_name: "Lawrence", last_name: "Osborne"),
  cover: Rails.root.join("db/images/forgiven.jpg").open
},
{
  title: "Fahrenheit 451",
  description: "",
  price: 6.86,
  stock: 5,
  category_id: 21,
  author: Author.create!(first_name: "Ray", last_name: "Bradbury"),
  cover: Rails.root.join("db/images/451.jpg").open
},
{
  title: "The Little Prince",
  description: "Translated by Irene Testot-Ferry. The Little Prince is a classic tale of equal appeal to children and adults. On one level it is the story of an airman's discovery, in the desert, of a small boy from another planet - the Little Prince of the title - and his stories of intergalactic travel, while on the other hand it is a thought-provoking allegory of the human condition. First published in 1943, the year before the author's death in action, this translation contains Saint-Exupery's delightful illustrations.",
  price: 4.04,
  stock: 5,
  category_id: 11,
  author: Author.create!(first_name: "Antoine", last_name: "de Saint-Exupery"),
  cover: Rails.root.join("db/images/prince.jpg").open
},
{
  title: "Sapiens: A Brief History of Humankind",
  description: "This is The Sunday Times Bestseller. Planet Earth is 4.5 billion years old. In just a fraction of that time, one species among countless others has conquered it. Us. We are the most advanced and most destructive animals ever to have lived. What makes us brilliant? What makes us deadly? What makes us Sapiens? In this bold and provocative book, Yuval Noah Harari explores who we are, how we got here and where we're going.",
  price: 14.37,
  stock: 5,
  category_id: 15,
  author: Author.create!(first_name: "Yuval Noah", last_name: "Harari"),
  cover: Rails.root.join("db/images/sapiens.jpg").open
},
{
  title: "The Art of Social Media: Power Tips for Power Users",
  description: "From Guy Kawasaki, the bestselling author of The Art of the Start and Enchantment, The Art of Social Media is a no-nonsense guide to becoming a social media superstar. By now it's clear that whether you're promoting a business, a product, or yourself, social media is near the top of what will determine your success or failure. And there are countless pundits, authors, and consultants eager to advise you. But there's no one quite like Guy Kawasaki, the legendary former chief evangelist for Apple and one of the pioneers of business blogging, tweeting, facebooking, tumbling, and much, much more.",
  price: 11.58,
  stock: 5,
  category_id: 3,
  author: Author.create!(first_name: "Guy", last_name: "Kawasaki"),
  cover: Rails.root.join("db/images/art_of_sm.jpg").open
},
{
  title: "Reality Check: The Irreverent Guide to Outsmarting, Outmanaging, and Outmarketing Your Competition",
  description: "\"Don't even think about trying to launch a startup without reading Guy Kawasaki's \"Reality Check.\"\" -\"BizEd\" For a quarter of a century, in his various guises as an entrepreneur, evangelist, venture capitalist, and guru, Guy Kawasaki has cast an irreverent eye on the dubious trends, sketchy theories, and outright foolishness of what so often passes for business today. Too many people frantically chase the Next Big Thing only to discover that all they've made is the Last Big Mistake. \"Reality Check\" is Kawasaki's all-in-one guide for starting and operating great organizations-ones that stand the test of time and ignore any passing fads in business theory. ",
  price: 11.58,
  stock: 5,
  category_id: 3,
  author: Author.create!(first_name: "Guy", last_name: "Kawasaki"),
  cover: Rails.root.join("db/images/reality_check.jpg").open
}])

Delivery.create!([
  {
    name: 'UPS Ground',
    price: 5.00
  },
  {
    name: 'UPS Two Day',
    price: 10.00
  },
  {
    name: 'UPS One Day',
    price: 15.00
}])

puts "Created #{Book.count} books."
