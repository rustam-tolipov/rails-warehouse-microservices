require 'faker'

puts "Seeding 10k products..."
10_000.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    sku: Faker::Alphanumeric.alphanumeric(number: 10).upcase,
    category: Faker::Commerce.department,
    price_cents: Faker::Number.between(from: 100, to: 100_000),
    available: [true, false].sample
  )
end
puts "Done."
