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

  def penalty_for_hour published_book
    #(0,00007 * кол-во полный лет, прошедших с момента издания книги * стоимость) + (0,000003 * кол-во страниц * стоимость) + (0,0005 * стоимость)
    (0.00007 * (DateTime.now.year - published_book.published_at - 1) * published_book.price) + (0.000003 * published_book.pages_quantity * published_book.price) + (0.0005 * published_book.price)
  end

  def penalty
    hours_ago = ((DateTime.now.new_offset(0) - issue_datetime).to_f * 24).round
    hours_ago > 0 ? (penalty_for_hour(reader_with_book.book) * hours_ago).round : 0    
  end

  def could_meet_each_other? first_author, second_author
    (first_author.year_of_birth..first_author.year_of_death).overlaps?(second_author.year_of_birth..second_author.year_of_death)
  end

  def days_to_buy
    ((reader_with_book.book.price / penalty_for_hour(reader_with_book.book)) / 24).ceil
  end

  def transliterate author
    replace = {

      'а' => 'a',   'б' => 'b',   'в' => 'v',
        'г' => 'h',   'д' => 'd',   'е' => 'e',   'є' => 'ie',
        'ж' => 'zh',  'з' => 'z',   'і' => 'i',
        'и' => 'y',   'й' => 'i',   'к' => 'k',   'ї' => 'i',
        'л' => 'l',   'м' => 'm',   'н' => 'n',   'ґ' => 'g',
        'о' => 'o',   'п' => 'p',   'р' => 'r',
        'с' => 's',   'т' => 't',   'у' => 'u',
        'ф' => 'f',   'х' => 'kh',  'ц' => 'ts',
        'ч' => 'ch',  'ш' => 'sh',  'щ' => 'shch',
        'ю' => 'iu',  'я' => 'ia',

        'А' => 'A',   'Б' => 'B',   'В' => 'V',
        'Г' => 'H',   'Д' => 'D',   'Е' => 'E',   'Є' => 'Ye',
        'Ж' => 'Zh',  'З' => 'Z',   'І' => 'I',
        'И' => 'Y',   'Й' => 'Y',   'К' => 'K',   'Ї' => 'Yi',
        'Л' => 'L',   'М' => 'M',   'Н' => 'N',   'Ґ' => 'G',
        'О' => 'O',   'П' => 'P',   'Р' => 'R',
        'С' => 'S',   'Т' => 'T',   'У' => 'U',
        'Ф' => 'F',   'Х' => 'Kh',  'Ц' => 'Ts',
        'Ч' => 'Ch',  'Ш' => 'Sh',  'Щ' => 'Shch',
        'Ю' => 'Yu',  'Я' => 'Ya', ' ' => ' ', '’' => ''
    }

   author.name.gsub(/#{replace.keys}/, replace)

  end

  def penalty_to_finish

    finish_date = DateTime.now.new_offset(0) + reader_with_book.time_to_finish.hours
    date_diff = ((finish_date - issue_datetime).to_f * 24).round
    date_diff > 0 ? (penalty_for_hour(reader_with_book.book) * date_diff).round : 0

    #date_diff = (((reader_with_book.time_to_finish.hours + DateTime.now.new_offset(0)) - issue_datetime).to_f * 24).round
    #date_diff > 0 ? penalty_for_hour(reader_with_book.book) * date_diff : 0
  end

  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
