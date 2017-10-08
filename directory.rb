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

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  counter = 0
  while counter < students.length do
    puts "#{counter + 1}. #{students[counter][:name]} (#{students[counter][:cohort]})"
    counter += 1
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

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
