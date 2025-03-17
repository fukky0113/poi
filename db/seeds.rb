# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.find_or_create_by(email: "onetime@onetime.com") do |user|
  user.name = "onetime"
  user.password = "onetime"
  user.password_confirmation = "onetime"
end

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

category = [ "可燃ごみ" ,"不燃ごみ","資源ごみ（紙類）","資源ごみ（プラスチック容器包装）","ペットボトル","ビン","缶","粗大ごみ","有害ごみ","家電リサイクル対象品"]

category.each do |n|
  Category.create!(g_type:  n)
end

