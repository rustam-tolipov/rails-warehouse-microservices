class Transaction < ApplicationRecord
  enum :direction, { in: "in", out: "out" }

  validates :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :direction, inclusion: { in: directions.keys }
end
