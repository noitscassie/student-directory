#first we add all the studrnts to an array
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_with_letter(students)
  puts "Which letter would you like to choose to see students whose name begins with that letter?"
  letter = gets.chomp.upcase!
  puts "Those students whose names begin with \"#{letter}\" are: "
  students.each_with_index do |student, index|
    if student[:name].to_s[0] == letter || student[:name].to_s[0].downcase == letter
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_under_12(students)
  puts "Those students whose names are shorter than 12 characters are..."
  students.each_with_index do |student, index|
    if student[:name].to_s.length < 12
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #empty array into which we will save the newly inputted students
  students = []
  #getting the first name to add
  name = gets.chomp
  #code to repeat whilst the name is not empty
  while !name.empty? do
    #add the student has to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    #get another name from the user
    name = gets.chomp
  end
  #return the array of students
  students
end

#nothing happens until we call the methods
students = input_students
print_header
print_under_12(students)
print_footer(students)
