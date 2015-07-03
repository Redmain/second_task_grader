class ReaderWithBook < Reader
  attr_accessor :book, :current_page

  def initialize  name, reading_speed, book, current_page
    @book = book
    @current_page = current_page
    super name, reading_speed
  end 

  def time_to_finish
    (book_price / @book.fine / 24).ceil
  end

  def book_price
  	@book.price
  end

  def book_author
    @book.author.name
  end

  def book_title
    @book.title
  end

  def book_pages_quantity
  	@book.pages_quantity
  end

  def book_published_at
    @book.published_at
  end

  def penalty_per_hour hours
    (@book.fine * hours.round).round
  end

end
