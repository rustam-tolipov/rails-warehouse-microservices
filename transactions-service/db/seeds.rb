puts "Seeding 5000 random transactions..."

directions = ["in", "out"]
sources = ["shipment", "manual", "return", "adjustment"]

5000.times do
  Transaction.create!(
    product_id: rand(1..10000), # assuming products from products-service
    quantity: rand(1..50),
    direction: directions.sample,
    source: sources.sample
  )
end

puts "Done seeding!"
