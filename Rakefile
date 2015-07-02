require 'gmail'
require 'pry'
require 'zip'
require 'csv'
require 'active_support/all'

desc "Make coffee"
task :check_homework do
  counter = 0
  results = []
  while counter < 50
  Gmail.connect('gmail_account', 'secret_token').mailbox("HomeWork").emails.each do |email|
    begin
      puts '='*80
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
      begin
        require "./tmp#{counter}/sandbox#{counter}/ruby_bursa_task_2/library_manager.rb" if File.exist?("./tmp#{counter}/sandbox#{counter}/ruby_bursa_task_2/library_manager.rb")
        require "./tmp#{counter}/sandbox#{counter}/library_manager.rb" if File.exist?("./tmp#{counter}/sandbox#{counter}/library_manager.rb")

        @leo_tolstoy = Author.new(1828, 1910, 'Leo Tolstoy')
        @oscar_wilde = Author.new(1854, 1900, 'Oscar Wilde')
        @noname = Author.new(1234, 1256, 'noname')
        @war_and_peace = PublishedBook.new(@leo_tolstoy, 'War and Peace', 1400, 3280, 1996)
        @ivan_testenko = ReaderWithBook.new('Ivan Testenko', 100, @war_and_peace, 328)
        @manager = LibraryManager.new(@ivan_testenko, (DateTime.now.new_offset(0) - 2.days))

        first, second, third, fourth, fifth = 5.times.map{0}

        if @manager.methods.include? :penalty
          return unless @manager.method(:penalty).parameters.count.zero?
          first += 2
          first += 4 if 0 == LibraryManager.new(@ivan_testenko, (DateTime.now.new_offset(0))).penalty
          first += 4 if [779...780, 784...785].any? { |q| (q).include? @manager.penalty }
        end
        if @manager.methods.include? :could_meet_each_other?
          return unless @manager.method(:could_meet_each_other?).parameters.count == 2
          second += 2
          second += 4 unless @manager.could_meet_each_other? @leo_tolstoy, @noname
          second += 4 if @manager.could_meet_each_other? @oscar_wilde, @leo_tolstoy
        end
        if @manager.methods.include? :days_to_buy
          return unless @manager.method(:days_to_buy).parameters.count.zero?
          third += 2 
          third += 8 if (3..4).include? @manager.days_to_buy
        end
        if @manager.methods.include? :transliterate
          return unless @manager.method(:transliterate).parameters.count == 1
          fourth += 2
          fourth += 4 if 'Ivan Franko' == @manager.transliterate('Іван Франко')
          fourth += 4 if 'Marko Vovchok' == @manager.transliterate('Марко Вовчок')
        end
        if @manager.methods.include? :penalty_to_finish
          return unless @manager.method(:penalty_to_finish).parameters.count.zero?
          fifth += 2
          fifth += 4 if [1258...1259, 1274...1275].any? { |q| (q).include?(@manager.penalty_to_finish) }
          @manager = LibraryManager.new(@ivan_testenko, (DateTime.now.new_offset(0) + 2.days))
          fifth += 4 if 0 == @manager.penalty_to_finish
        end
        Object.send(:remove_const, :LibraryManager)
        total = [first, second, third, fourth, fifth].sum
        student_grade << total << first << second << third << fourth << fifth
      rescue Exception => e  
        puts e.message
        puts e.backtrace.inspect  
      end    
      puts student_grade.to_s
      results << student_grade
    rescue Exception => e  
      puts e.message
      puts e.backtrace.inspect  
    end
  end
    counter += 1
  end
  CSV.open("hw_2_grades.csv", "w") do |csv|
    results.each{ |res| csv << res }
  end
end
