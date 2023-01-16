class Review < ApplicationRecord

  geocoded_by :address
  after_validation :geocode

  validates :title, presence: true
  validates :body, length: { minimum: 10 }
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :price, presence: true
  validates :address, presence: true

  def to_param
    id.to_s + "-" + title.parameterize
  end

  def price_in_dollar_signs
    # if price <= 1
    #   "$"
    # elsif price >= 3
    #   "$$$"
    # else
    #   "$$"
    # end

    "$" * [1, price, 3].sort[1]
  end
end
