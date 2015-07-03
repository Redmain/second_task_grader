class PublishedBook < Book
  attr_accessor :price, :pages_quantity, :published_at

  def initialize author, title, price, pages_quantity, published_at
    @price = price
    @pages_quantity = pages_quantity
    @published_at = published_at
    super author, title
  end

  def age
    Time.now.utc.year - published_at - 1	
  end  

  def penalty_per_hour
  	price_penalty = price * 0.0005 
  	pages_penalty = 0.000003 * price * pages_quantity
  	age_penalty = 0.00007 * price * age

  	price_penalty + pages_penalty + age_penalty
  end

  def age_from_date date
    date.year - published_at - 1
  end

  def penalty_per_hour_from_date date
    age_book = age_from_date date

    price_penalty = price * 0.0005 
    pages_penalty = 0.000003 * price * pages_quantity
    age_penalty = 0.00007 * price * age_book

    price_penalty + pages_penalty + age_penalty
  end
end
