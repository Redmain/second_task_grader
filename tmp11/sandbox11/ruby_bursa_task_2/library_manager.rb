require 'active_support/all'
require 'pry'
class LibraryManager

  require_relative 'author.rb'
  require_relative 'book.rb'
  require_relative 'published_book.rb'
  require_relative 'reader.rb'
  require_relative 'reader_with_book.rb'

  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end

  def penalty

    hours_overdue = ((Time.now.utc.to_i - issue_datetime.to_time.to_i) / 3600)
    price_penalty = reader_with_book.book_price * hours_overdue * 0.0005
    pages_penalty = 0.000003 * reader_with_book.book_price * reader_with_book.book_pages_quantity * hours_overdue
    age_penalty = 0.00007 * reader_with_book.book_price * reader_with_book.book.age * hours_overdue

  
    #binding.pry
    penalty = (price_penalty + pages_penalty + age_penalty).round


  end

  def could_meet_each_other? first_author, second_author
        first_author.can_meet? second_author
    second_author.can_meet? first_author
    (first_author.year_of_birth <= second_author.year_of_death) && (second_author.year_of_birth <= first_author.year_of_death)
  end


  end

  def days_to_buy

  end

  def transliterate author
     hash_tab = {  'А'=>'A'     ,'а'=>'a',
                  'Б'=>'B'     ,'б'=>'b',
                  'В'=>'V'     ,'в'=>'v',
                  'Г'=>'H'     ,'г'=>'h',
                  'Ґ'=>'G'     ,'ґ'=>'g',
                  'Д'=>'D'     ,'д'=>'d',
                  'Е'=>'E'     ,'е'=>'e',
                  'Є'=>'Ye'    ,'є'=>'ie',
                  'Ж'=>'Zh'    ,'ж'=>'zh',
                  'З'=>'Z'     ,'з'=>'z',
                  'И'=>'Y'     ,'и'=>'y',
                  'І'=>'I'     ,'і'=>'i',
                  'Ї'=>'Yi'    ,'ї'=>'i',
                  'Й'=>'Y'     ,'й'=>'i',
                  'К'=>'K'     ,'к'=>'k',
                  'Л'=>'L'     ,'л'=>'l',
                  'М'=>'M'     ,'м'=>'m',
                  'Н'=>'N'     ,'н'=>'n',
                  'О'=>'O'     ,'о'=>'o',
                  'П'=>'P'     ,'п'=>'p',
                  'Р'=>'R'     ,'р'=>'r',
                  'С'=>'S'     ,'с'=>'s',
                  'Т'=>'T'     ,'т'=>'t',
                  'У'=>'U'     ,'у'=>'u',
                  'Ф'=>'F'     ,'ф'=>'f',
                  'Х'=>'Kh'    ,'х'=>'kh',
                  'Ц'=>'Ts'    ,'ц'=>'ts',
                  'Ч'=>'Ch'    ,'ч'=>'ch',
                  'Ш'=>'Sh'    ,'ш'=>'sh',
                  'Щ'=>'Shch'  ,'щ'=>'shch',
                  'Ю'=>'Yu'    ,'ю'=>'iu',
                  'Я'=>'Ya'    ,'я'=>'ia',
                  '’'=>'',
                  'ь'=>''}
    eng_name = ''
    author.name.each_char do |symb|
      eng_name += (hash_tab.has_key?(symb) ? hash_tab[symb] : symb)
    end
    eng_name
  end

  end


  def penalty_to_finish
     def penalty_to_finish
    exp = DateTime.now.new_offset(0) + @reader_with_book.time_to_finish/24.0
    res = (@reader_with_book.book.price  hour_rate  (exp - @issue_datetime)*24)
    res > 0 ? res.round : 0
  end

  private :hour_rate

  def email_notification_params
      {
        penalty: "#{(hour_rate*@reader_with_book.book.price).round/100.0}",
        hours_to_deadline: "#{ 
          x = (@issue_datetime - DateTime.now.new_offset(0)).to_f * 24
          x > 0 ? x.round : 0
          }"
      }
  end

  end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
