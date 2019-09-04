
user = User.create!(username: "ntphuc",
  email: "ntphuc98it@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  roles: 1)

category = Category.create!(
  name: "Dao",
  parent_id: nil)

# fake products
99.times do |n|
  name = Faker::Name.name
  description = Faker::Lorem.paragraph
  price = Faker::Number.number(digits: 5)
  quantily = Faker::Number.number(digits: 2)
  user_id = user.id
  category_id = category.id
  product = Product.create!(name: name,
    description: description,
    price: price,
    quantily: quantily,
    user_id: user_id,
    category_id: category_id)
  ProductImage.create!(
    picture: Rails.root.join("app/assets/images/242x200.png").open,
    product_id: product.id)
  ProductImage.create!(
    picture: Rails.root.join("app/assets/images/242x200.png").open,
    product_id: product.id)
  ProductImage.create!(
    picture: Rails.root.join("app/assets/images/242x200.png").open,
    product_id: product.id)
end

# # fake users
# 99.times do |n|
#   username  = "ntphuc#{n}"
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   role = 1
#   User.create!(username:  username,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                roles: role)
# end
