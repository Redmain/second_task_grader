class PublishedBook < Book
  attr_accessor :price, :pages_quantity, :published_at

  def initialize author, title, price, pages_quantity, published_at
    @price = price
    @pages_quantity = pages_quantity
    @published_at = published_at
    super author, title
  end

  def age
    # OLD
    # absolute = (Time.now.utc.to_time - published_at.to_time) / 3600 / 24 / 365.25
    # if (absolute - absolute.round).abs < 1 / 365.25 then
    #   return absolute.round
    # else 
    #   return absolute.floor
    # end

    # HW2
    Time.now.utc.year - published_at
    
    # HW3
    # Time.now.utc.year - published_at + 1 
  end

  def penalty_per_hour
    price_penalty = 0.0005 * @price
    pages_penalty = 0.000003 * @price * @pages_quantity
    age_penalty   = 0.00007 * @price * age

    price_penalty + pages_penalty + age_penalty
  end
end