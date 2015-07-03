class PublishedBook < Book
  attr_accessor :price, :pages_quantity, :published_at

  @@count = 0
  @book_age = 0

  def initialize author, title, price, pages_quantity, published_at
    @price = price
    @pages_quantity = pages_quantity
    @published_at = published_at
    super author, title
    @@count += 1		
    age
  end

  def age
  	@book_age = Time.now.year - published_at - 1
  end

  def penalty_per_hour
    price_penalty = price*0.0005
    pages_penalty = price*0.000003*pages_quantity
    age_penalty = price*0.00007*@book_age
    penalty_per_hour = (price_penalty + pages_penalty + age_penalty).round(0)
  end

  #def self.total_number (*books)
  	#books.map (&:price).inject(0, &:+)
  #end

end
