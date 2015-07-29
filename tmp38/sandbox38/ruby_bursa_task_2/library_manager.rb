require 'active_support/all'
require 'pry'

  require_relative 'author.rb'
  require_relative 'book.rb'
  require_relative 'published_book.rb'
  require_relative 'reader.rb'
  require_relative 'reader_with_book.rb'

class LibraryManager
  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end

  def penalty
    late_hours = (DateTime.now.new_offset(0).to_time - issue_datetime.to_time) / 3600.0
    return 0 if late_hours <= 0 || reader_with_book.book.price <= 0
    (reader_with_book.book.penalty_per_hour * late_hours).round
  end

  def could_meet_each_other? first_author, second_author
    return false unless first_author.year_of_birth <= first_author.year_of_death and second_author.year_of_birth <= second_author.year_of_death
    second_author.year_of_birth <= first_author.year_of_death and first_author.year_of_birth <= second_author.year_of_death
  end

  def days_to_buy
    return 0 if reader_with_book.book.price <= 0
    days = reader_with_book.book.price.to_f / (24 * reader_with_book.book.penalty_per_hour)
    rand < 0.5 ? days.ceil : days.floor
  end

  def transliterate author
    replacement_dict = {'А' => 'A', 'а' => 'a',
                        'Б' => 'B', 'б' => 'b',
                        'В' => 'V', 'в' => 'v',
                        'Г' => 'H', 'г' => 'h',
                        'Ґ' => 'G', 'ґ' => 'g',
                        'Д' => 'D', 'д' => 'd',
                        'Е' => 'E', 'е' => 'e',
                        'З' => 'Z', 'з' => 'z',
                        'И' => 'Y', 'и' => 'y',
                        'І' => 'I', 'і' => 'i',
                        'К' => 'K', 'к' => 'k',
                        'Л' => 'L', 'л' => 'l',
                        'М' => 'M', 'м' => 'm',
                        'Н' => 'N', 'н' => 'n',
                        'О' => 'O', 'о' => 'o',
                        'П' => 'P', 'п' => 'p',
                        'Р' => 'R', 'р' => 'r',
                        'С' => 'S', 'с' => 's',
                        'Т' => 'T', 'т' => 't',
                        'У' => 'U', 'у' => 'u',
                        'Ф' => 'F', 'ф' => 'f',

                        'Ж(?=\p{Lu})' => 'ZH',   'Ж(?=(\b|\p{Ll}))' => 'Zh',   'ж' => 'zh',
                        'Х(?=\p{Lu})' => 'KH',   'Х(?=(\b|\p{Ll}))' => 'Kh',   'х' => 'kh',
                        'Ц(?=\p{Lu})' => 'TS',   'Ц(?=(\b|\p{Ll}))' => 'Ts',   'ц' => 'ts',
                        'Ч(?=\p{Lu})' => 'CH',   'Ч(?=(\b|\p{Ll}))' => 'Ch',   'ч' => 'ch',
                        'Ш(?=\p{Lu})' => 'SH',   'Ш(?=(\b|\p{Ll}))' => 'Sh',   'ш' => 'sh',
                        'Щ(?=\p{Lu})' => 'SHCH', 'Щ(?=(\b|\p{Ll}))' => 'Shch', 'щ' => 'shch',

                        '\bЄ(?=\p{Lu})' => 'YE', '\bЄ(?=(\b|\p{Ll}))' => 'Ye', '\bє' => 'ye',
                        '\BЄ(?=\p{Lu})' => 'IE', '\BЄ(?=(\b|\p{Ll}))' => 'Ie', '\Bє' => 'ie',

                        '\bЇ(?=\p{Lu})' => 'YI', '\bЇ(?=(\b|\p{Ll}))' => 'Yi', '\bї' => 'yi', 
                        '\BЇ' => 'I', '\Bї' => 'i',

                        '\bЙ' => 'Y', '\bй' => 'y', 
                        '\BЙ' => 'I', '\Bй' => 'i',

                        '\bЮ(?=\p{Lu})' => 'YU', '\bЮ(?=(\b|\p{Ll}))' => 'Yu', '\bю' => 'yu',
                        '\BЮ(?=\p{Lu})' => 'IU', '\BЮ(?=(\b|\p{Ll}))' => 'Iu', '\Bю' => 'iu',

                        '\bЯ(?=\p{Lu})' => 'YA', '\bЯ(?=(\b|\p{Ll}))' => 'Ya', '\bя' => 'ya',
                        '\BЯ(?=\p{Lu})' => 'IA', '\BЯ(?=(\b|\p{Ll}))' => 'Ia', '\Bя' => 'ia'}

    # binding.pry
    without_apostrophe = author.name.gsub(/(?:(?<=\p{L})[’'](?=\p{L})|ь)/i, '')
    replacement_dict.each {|key, value| without_apostrophe.gsub!(/#{key}/, "#{value}")}
    without_apostrophe
  end

  def penalty_to_finish
    diff_hours = (DateTime.now.new_offset(0).to_f - issue_datetime.to_f) / 3600
    pages_to_read = reader_with_book.book.pages_quantity - reader_with_book.current_page
    hours_to_read = pages_to_read.to_f / reader_with_book.reading_speed
    late_hours = diff_hours + hours_to_read
    # binding.pry
    return 0 if reader_with_book.book.price <= 0 or 
                not (0 <= reader_with_book.current_page and reader_with_book.current_page <= reader_with_book.book.pages_quantity) or
                late_hours <= 0
    (reader_with_book.book.penalty_per_hour * late_hours).round
  end

  # def email_notification_params
  #   {
  #     penalty: "some code",
  #     hours_to_deadline: "some code",
  #   }
  # end

  # def email_notification
  #   #use email_notification_params
  # end
end
