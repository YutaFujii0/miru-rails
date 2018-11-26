# Delete all data from development env
puts "Destroy Foods/Menus/Results tabels"
Food.destroy_all
Menu.destroy_all
Language.destroy_all

# results table should be empty since it's a joint table
raise unless Result.all.empty?

# if there is no user instance, create one
if User.all.count.zero?
  User.create!({
    email: Faker::Internet.email,
    password: "123456",
    # name: Faker::Internet.username,
    # avatar: ""
  })
end

# seeds for foods table =============================
food_name_array = [
"生カキ",
"お刺身盛合せ",
"秋田 しいたけ",
"生カキポン酢",
"天ぷら",
"サーモンとキノコ",
"サーモンとキノコホイル焼き",
"クリームピザ",
"カキフライ",
"谷中生姜甘酢漬",
"バター醤油焼き",
"白子ポン酢",
"スズキ"
]

puts "Start creating foods table"
food_name_array.each do |element|
  Food.create!({
    name: element,
    deleted: false
  })
end
puts "Finished (foods table)"

# seeds for menus table =============================
menu_img_array = [
  "https://res.cloudinary.com/dwoaw9y1s/image/upload/v1542700912/menu.jpg",
  "https://res.cloudinary.com/dwoaw9y1s/image/upload/v1542700966/IMG_3476.heic"
]

puts "Start creating menus table"
menu_img_array.each do |element|
  Menu.create!({
    user_id: User.all.sample.id,
    remote_photo_url: element
  })
end
puts "Finished (menus table)"

# seeds for results table =============================
puts "Start creating results table"
Menu.all.each do |menu|
  rand(2..5).times do
    Result.create!({
      menu_id: menu.id,
      food_id: Food.all.sample.id
    })
  end
end
puts "Finished (results table)"

# seeds for languages table =============================
puts "Start creating languages table"

language_base = [
  {code: "ja", name: "Japanese", meal_is: "食事"},
  {code: "ko", name: "Korean", meal_is: "식사"},
  {code: "ru", name: "Russian", meal_is: "еда"}
]

language_base.each do |language|
  Language.create!(language)
end

puts "Finished (languages table)"


puts "Finished creating seeds"
puts "instance - first id"
puts "-------------------"
puts "User     - #{User.first.id}"
puts "Food     - #{Food.first.id}"
puts "Menu     - #{Menu.first.id}"
puts "Result   - #{Result.first.id}"
