class ReaderWithBook < Reader
  attr_accessor :book, :current_page

  def initialize  name, reading_speed, book, current_page
    @book = book
    @current_page = current_page
    super name, reading_speed
  end 

  def time_to_finish
    (book.pages_quantity - current_page) / reading_speed
  end
  def penalty hours
    (amazing_book_penalty_per_hour * hours).round
    
  end
  def method_name
     now_date = DateTime.now.new_offset(0)
    if now_date.to_i > issue_datetime.to_i then
        pane_hours = (now_date.to_f - issue_datetime.to_f)/3600
        pane_n = (price*0.001*pane_hours).round

    residue_pages = pages_quantity - current_page
    residue_pane = (residue_pages/reading_speed)*price*0.001
    itogo = residue_pane + pane_n
  else 
    residue_pages = pages_quantity - current_page
    residue_hours = residue_pages/reading_speed
    if (issue_datetime.to_f - now_date.to_f)/3600 > residue_hours then
      pane = 0
    else
      residue_pane = residue_hours*price*0.001
      itogo = residue_pane 
    end
  end
    
  end
end
