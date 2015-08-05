require 'gmail'
require 'pry'
require 'zip'
require 'csv'
require 'active_support/all'

desc "Make coffee"
task :download_homeworks_and_unzip do
  results = []
  Gmail.connect('gmail_account', 'secret_token').mailbox("HomeWork2").emails.each_with_index do |email, counter|
    begin
      puts '=' * 80
      student_grade = []
      student_name = email.message.subject.split('.')[0] #=> ["Мананников Сергей", " HW1", " Tasks1"]
      puts "checking #{student_name}, #{counter}"
      student_grade << counter << student_name
      FileUtils.mkdir "#{Dir.pwd}/tmp#{counter}"
      FileUtils.mkdir "#{Dir.pwd}/tmp#{counter}/sandbox#{counter}"
      email.message.attachments.each do |f|
        File.write(File.join("#{Dir.pwd}/tmp#{counter}", 'ruby_bursa_task_2.zip'), f.body.decoded)
      end
      Zip::File.open("#{Dir.pwd}/tmp#{counter}/ruby_bursa_task_2.zip") do |zip_file|
        zip_file.each { |f| zip_file.extract(f, File.join("#{Dir.pwd}/tmp#{counter}/sandbox#{counter}", f.name)) }
      end
      puts student_grade.to_s
      results << student_grade
    rescue Exception => e  
      puts e.message
      puts e.backtrace.inspect  
    end
  end
  CSV.open("hw_2_grades.csv", "a+") do |csv|
    results.each{ |res| csv << res }
  end
end

desc "Make tea"
task :check_homework do
  results = []
  file_name = 'library_manager'
  homework_count = Dir.entries('.').reject{ |d| d.scan(/tmp.*/).empty? }.sort_by{ |q| q.split('tmp')[1].to_i }
  homework_count.each do |dir|
    begin
      counter = dir.split('tmp')[1]
      puts '=' * 80
      puts dir
      path = "./#{dir}/sandbox#{counter}/ruby_bursa_task_2/#{file_name}.rb"
      # replace = text.gsub(/require '(\.\/)([^']*)'/, "require_relative \'\2\'")
      # File.open(path, "w") {|file| file.puts replace}
      require path if File.exist?(path)

      @leo_tolstoy = Author.new(1828, 1910, 'Leo Tolstoy')
      @oscar_wilde = Author.new(1854, 1900, 'Oscar Wilde')
      @noname = Author.new(1234, 1256, 'noname')
      @war_and_peace = PublishedBook.new(@leo_tolstoy, 'War and Peace', 1400, 3280, 1996)
      @ivan_testenko = ReaderWithBook.new('Ivan Testenko', 100, @war_and_peace, 328)
      @manager = LibraryManager.new(@ivan_testenko, (DateTime.now.new_offset(0) - 2.days))

      @franko  = Author.new(1854, 1900, 'Іван Франко')
      @vovchok = Author.new(1854, 1900, 'Марко Вовчок')

      first, second, third, fourth, fifth = 5.times.map{0}

      begin
        if @manager.methods.include? :penalty
          if @manager.method(:penalty).parameters.count.zero?
            first += 2
            first += 4 if 0 == LibraryManager.new(@ivan_testenko, (DateTime.now.new_offset(0))).penalty
            first += 4 if [779..780, 784..785].any? { |q| (q).include? @manager.penalty }
          end
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      begin
        if @manager.methods.include? :could_meet_each_other?
          if @manager.method(:could_meet_each_other?).parameters.count == 2
            second += 2
            second += 4 unless @manager.could_meet_each_other? @leo_tolstoy, @noname
            second += 4 if @manager.could_meet_each_other? @oscar_wilde, @leo_tolstoy
          end
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      begin
        if @manager.methods.include? :days_to_buy
          if @manager.method(:days_to_buy).parameters.count.zero?
            third += 2 
            third += 8 if (3..4).include? @manager.days_to_buy
          end
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      begin
        if @manager.methods.include? :transliterate
          if @manager.method(:transliterate).parameters.count == 1
            fourth += 2
            fourth += 4 if 'Ivan Franko' == @manager.transliterate(@franko)
            fourth += 4 if 'Marko Vovchok' == @manager.transliterate(@vovchok)
          end
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      begin
        if @manager.methods.include? :penalty_to_finish
          if @manager.method(:penalty_to_finish).parameters.count.zero?
            fifth += 2
            fifth += 4 if [1250..1251, 1258..1259, 1274..1275].any? { |q| (q).include?(@manager.penalty_to_finish) }
            @manager = LibraryManager.new(@ivan_testenko, (DateTime.now.new_offset(0) + 2.days))
            fifth += 4 if 0 == @manager.penalty_to_finish
          end
        end
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      Object.send(:remove_const, 'LibraryManager') if defined? LibraryManager
      Object.send(:remove_const, 'Author') if defined? Author
      Object.send(:remove_const, 'Book') if defined? Book
      Object.send(:remove_const, 'PublishedBook') if defined? PublishedBook
      Object.send(:remove_const, 'Reader') if defined? Reader
      Object.send(:remove_const, 'ReaderWithBook') if defined? ReaderWithBook
      total = [first, second, third, fourth, fifth].sum
      student_grade = []
      student_grade << counter << total << first << second << third << fourth << fifth
      results << student_grade
    rescue Exception => e  
      puts e.message
      puts e.backtrace.inspect  
    end
    Object.send(:remove_const, 'LibraryManager') if defined? LibraryManager
    Object.send(:remove_const, 'Author') if defined? Author
    Object.send(:remove_const, 'Book') if defined? Book
    Object.send(:remove_const, 'PublishedBook') if defined? PublishedBook
    Object.send(:remove_const, 'Reader') if defined? Reader
    Object.send(:remove_const, 'ReaderWithBook') if defined? ReaderWithBook
  end
  CSV.open("hw_2_grades.csv", "a+") do |csv|
    results.each{ |res| csv << res }
  end
end

desc "And clear"
task :remove_homeworks do
  results = []
  begin
    system('rm -rf tmp*')
  rescue Exception => e  
    puts e.message
    puts e.backtrace.inspect  
  end
  CSV.open("hw_2_grades.csv", "a+") do |csv|
    results.each{ |res| csv << res }
  end
end
