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
  ["Input the students", Proc.new{@students = input_students}],
  ["Show the students", Proc.new{show_students}],
  ["Save the list of students", Proc.new{save_students}],
  ["Load the list of students", Proc.new{load_students}],
  ["Edit a student", Proc.new{edit_student}],
  ["Remove a student", Proc.new{remove_student}],
  ["Exit", Proc.new{exit}]
]

#Adding in the CSV libraries
require 'csv'

#Top-level menu method
def interactive_menu
  puts "Loading program..."
  try_load_students
  loop do
    print_menu
    process STDIN.gets.chomp
  end
end

#Method to load a list of students passed method_namein as an argument on the command line
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
  @menu_options.each_with_index { |option, index| puts "#{index + 1}. #{option[0]}" }
end

#Method to execute the user's choice of action
def process(selection)
  if selection.to_i <= @menu_options.length && selection.to_i > 0
    @menu_options[selection.to_i - 1][1].call
    puts "Congratulations, your choice was successfully carried out."
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
    puts "And what cohort are tzhey in?"
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
  write_to_csv(STDIN.gets.chomp)
end

#Method to write data to a CSV file
def write_to_csv file
  CSV.open(file, "w") do |f|
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
  csv_to_array(user_file)
  puts "Loaded #{@students.count} students from #{user_file}"
end

#Method to load a CSV file of students ausernd cohorts and add each line to a new array
def csv_to_array csv_file
  file = File.open(csv_file, "r") do |f|
    @students = []
    CSV.foreach(f) do |line|
      name, cohort = line[0], line[1]
      add_student(name, cohort)
    end
  end
end

#Method to allow the user to edit a student's name or cohort
def edit_student
  puts "Which student would you like to edit?"
end

#Method to check if a student exists in the directory
def check
  student = STDIN.gets.chomp
  loop do
    if !(@students.any? { |s| s[:name] == student})
      puts "Sorry, #{student} is not in the directory. Please re-enter the name of the student"
    else
      break
    end
    student = STDIN.gets.chomp
  end
  return student
end

#Method to allow the user to remove a student from the directory
def remove_student
  print_by_cohort
  puts "Which student would you like to remove? Please type in that student's name from the list above"
  student_to_remove = check
  @students.delete_if {|student| student.fetch(:name) == student_to_remove}
  puts "#{student_to_remove} has been deleted from the directory!"
end

#Method to allow the user to edit a student in the directory
def edit_student
  print_by_cohort
  puts "Which student would you like to edit? Please type in that student's name from the list above"
  student_to_edit = check
  puts "Selected #{student_to_edit}"
  puts "Would you like to edit their name or their cohort?"
  puts "Enter 1 to edit their name, and 2 to edit their cohort"
  user_choice = STDIN.gets.chomp
  loop do
    if user_choice.to_i == 1
      edit_name student_to_edit
      break
    elsif user_choice.to_i == 2
      edit_cohort student_to_edit
      break
    else
      puts "Sorry, that was not a valid selection. Enter 1 to edit a student's name, and 2 to edit their cohort"
      user_choice = STDIN.gets.chomp
    end
  end
end

#Method to edit a student's name
def edit_name name
  to_edit = @students.select { |s| s[:name] == name}
  puts "And what would you like to rename this student to?"
  new_name = STDIN.gets.chomp
  to_edit = to_edit[0]
#  puts to_edit.class
#  puts to_edit
  to_edit[:name] = new_name
  puts "Success! #{name}'s name has been updated to #{new_name}'"
end

#Method to edit a student's cohort
def edit_cohort student

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

#Method to display own source code
def print_source_code
  $><<IO.read($0)
end


#Executing the code
interactive_menu
