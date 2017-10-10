#Declaring global variables of possible cohorts and empty array of students
@possible_cohorts = [
  :january,
  :february,
  :march,
  :april,
  :may,
  :june,
  :july,
  :august,
  :september,
  :october,
  :november,
  :december
]
@students = []
@menu_options = [
  "Input the students",
  "Show the students",
  "Save the list of students",
  "Load the list of students",
  "Exit"
]

require 'csv'

#Top-level menu method
def interactive_menu
  puts "Loading program..."
  sleep(2)
  try_load_students
  loop do
    print_menu
    process STDIN.gets.chomp
    puts "Congratulations, your choice was successfully carried out."
  end
end

#Method to load a list of students passed in as an argument on the command line
def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
  elsif File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

#Method to print the menu
def print_menu
  @menu_options.each_with_index do |option, index|
    puts "#{index + 1}. #{option}"
  end
#  puts "1. Input the students"
#  puts "2. Show the students"
#  puts "3. Save the list to students.csv"
#  puts "4. Load the list from students.csv"
#  puts "9. Exit"
end

#Method to execute the user's choice of action
def process(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "5"
    exit
  else
    puts "I don't know what you meant, please try again"
  end
end

#Method to allow the user to add students to the directory
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "And what cohort are they in?"
    cohort = STDIN.gets.chomp
    while !(@possible_cohorts.include? cohort.downcase.to_sym)
      puts "Sorry, that was not a valid option. Please select a month as the cohort you will be joining."
      cohort = STDIN.gets.chomp
    end
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
  @students
end

#Methods to allow the user to print the list of students with header and footer; the default is to print by cohort
#Alternative printing methods are at the end of the program
def show_students
  print_header
  print_by_cohort
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts "-------------".center(80)
end
def print_by_cohort
  if @students.length > 0
    puts "These are the students of Villains Academy, grouped by their cohort:".center(80)
    iterator = 0
    student_counter = 1
    while iterator <= @possible_cohorts.length
      @students.each do |student|
        if student[:cohort] == @possible_cohorts[iterator]
          puts "#{student_counter}. #{student[:name]} (#{student[:cohort]} cohort)".center(80)
          student_counter += 1
        end
      end
      iterator += 1
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end
def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  elsif @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  end
end

#Method to allow the user to save new students added to a .csv file
def save_students
  puts "Where would you like to save the students to?"
  CSV.open(STDIN.gets.chomp, "w") do |f|
  #file = File.open(STDIN.gets.chomp, "w") do |f|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data
      f.puts csv_line
    end
  end
end

#Method to allow the user to load a list of students
def load_students
  puts "Which file would you like to load students from?"
  user_file = STDIN.gets.chomp
  if !File.exist?(user_file)
    user_file = "students.csv"
    puts "Sorry, that file does not exist. Loading students from default file: students.csv"
  end
  file = File.open(user_file, "r") do |f|
    CSV.foreach(f) do |line|
      name, cohort = line[0], line[1]
      add_student(name, cohort)
    end
    puts "Loaded #{@students.count} students from #{f}"
  end
end

#Alternative printing methods
def print_students
  if @students.length > 1
    counter = 0
    while counter < @students.length do
      puts "#{counter + 1}. #{@students[counter][:name]} (#{@students[counter][:cohort]}).".center(80)
      counter += 1
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end
def print_with_letter
  if @students.length > 1
    puts "Which letter would you like to choose to see students whose name begins with that letter?"
    letter = STDIN.gets.chomp.upcase!
    puts "Those students whose names begin with \"#{letter}\" are: "
    @students.each_with_index do |student, index|
      if student[:name].to_s[0] == letter || student[:name].to_s[0].downcase == letter
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end
def print_under_12
  if @students.length > 0
    puts "Those students whose names are shorter than 12 characters are..."
    @students.each_with_index do |student, index|
      if student[:name].to_s.length < 12
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end

#Helper method to add a student to the array - either from user input or a loaded file
def add_student(name, cohort)
  @students << {name: name, cohort: cohort.downcase.to_sym}
end


#Executing the code
interactive_menu
