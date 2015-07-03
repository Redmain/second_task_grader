class PublishedBook < Book
  attr_accessor :price, :pages_quantity, :published_at

  def initialize author, title, price, pages_quantity, published_at
    @price = price
    @pages_quantity = pages_quantity
    @published_at = published_at
    super author, title
  end

  def penalty_an_hour
    year_penalty = (DateTime.now.new_offset(0).year - published_at - 1) * 0.00007 * price
    pages_penalty = 0.000003 * pages_quantity * price
    cost_penalty = 0.0005 * price
    (year_penalty + pages_penalty + cost_penalty)
  end
end
