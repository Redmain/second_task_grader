
class PublishedBook < Book
  attr_accessor :price, :pages_quantity, :published_at

  def initialize author, title, price, pages_quantity, published_at
    @price = price
    @pages_quantity = pages_quantity
    @published_at = published_at
    super author, title
  end

  def fine
    a = 0.00007  * ((DateTime.now - @published_at.year).year - 1) * @price
    b = 0.000003 * @pages_quantity * @price
    c = 0.0005	 * @price
    a + b + c
  end

end
