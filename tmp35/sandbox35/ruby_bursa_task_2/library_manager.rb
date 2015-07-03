require 'active_support/all'
require 'pry'
require_relative 'author.rb'
require_relative 'book.rb'
require_relative 'published_book.rb'
require_relative 'reader.rb'
require_relative 'reader_with_book.rb'

class LibraryManager

  RATE_BY_YEARS  = 0.00007
  RATE_BY_PAGES  = 0.000003
  RATE_BY_PPRICE = 0.0005

  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end

  def rate_at_hour
    RATE_BY_YEARS   * (DateTime.now.year - @reader_with_book.book.published_at) + 
      RATE_BY_PAGES * @reader_with_book.book.pages_quantity + 
      RATE_BY_PPRICE
  end

  def penalty
    [0, (rate_at_hour * @reader_with_book.book.price * (DateTime.now.new_offset(0) - @issue_datetime).to_f * 24).round].max
  end

  def could_meet_each_other? first_author, second_author
    # на выбор - любая из 3 строк при условии, что в author.rb правильно прописан <can_meet?>
    #first_author.can_meet? second_author
    #second_author.can_meet? first_author
    (first_author.year_of_birth <= second_author.year_of_death) && (second_author.year_of_birth <= first_author.year_of_death)
  end

  def days_to_buy
    (1 / rate_at_hour / 24).ceil
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

  def penalty_to_finish
    exp_date = DateTime.now.new_offset(0) + @reader_with_book.time_to_finish / 24.0
    res = [0, ((@reader_with_book.book.price * rate_at_hour * (exp_date - @issue_datetime) * 24)).round].max
  end

  def email_notification_params 
    {
        penalty: "#{ (rate_at_hour * @reader_with_book.book.price).round / 100.0 }",
        hours_to_deadline: "#{ [0, ((@issue_datetime - DateTime.now.new_offset(0)).to_f * 24).round].max }"
    }
  end

  def email_notification
<<-TEXT
Hello, #{@reader_with_book.name}!
You should return a book "#{@reader_with_book.book.title}" authored by #{@reader_with_book.book.author.name} in #{email_notification_params[:hours_to_deadline]} hours.

Otherwise you will be charged $#{email_notification_params[:penalty]} per hour.
TEXT
  end

end
