

#writing the method to input students

def input_students cohorts
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #empty array into which we will save the newly inputted students
  students = []
  #getting the first name to add
  name = gets.chomp
  #code to repeat whilst the name is not empty
  while !name.empty? do
    puts "And what cohort are they in?"
    cohort = gets.chomp
    while !(cohorts.include? cohort.downcase.to_sym)
      puts "Sorry, that was not a valid option. Please select a month as the cohort you will be joining."
      cohort = gets.chomp
    end
    students << {name: name, cohort: cohort.downcase.to_sym}
    #add the student has to the array
    puts "Now we have #{students.count} students"
    #get another name from the user
    name = gets.chomp
  end
  #return the array of students
  students
end


#writing various printing methods

def print_header
  puts "The students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print(students)
  if students.length > 1
    counter = 0
    while counter < students.length do
      puts "#{counter + 1}. #{students[counter][:name]} (#{students[counter][:cohort]}).".center(80)
      counter += 1
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end

def print_with_letter(students)
  if students.length > 1
    puts "Which letter would you like to choose to see students whose name begins with that letter?"
    letter = gets.chomp.upcase!
    puts "Those students whose names begin with \"#{letter}\" are: "
    students.each_with_index do |student, index|
      if student[:name].to_s[0] == letter || student[:name].to_s[0].downcase == letter
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end

def print_under_12(students)
  if students.length > 0
    puts "Those students whose names are shorter than 12 characters are..."
    students.each_with_index do |student, index|
      if student[:name].to_s.length < 12
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
  else
    puts "Sorry, you did not add any students to Villains Academy, so there is no list to print!"
  end
end

def print_by_cohort(students, cohorts)
  if students.length > 0
    puts "These are the students of Villains Academy, grouped by their cohort:".center(80)
    iterator = 0
    student_counter = 1
    while iterator <= cohorts.length
      students.each do |student|
        if student[:cohort] == cohorts[iterator]
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

def print_footer(students)
  if students.count == 1
    puts "Overall, we have #{students.count} great student"
  elsif students.count > 1
    puts "Overall, we have #{students.count} great students"
  end
end

#writing the method for the interactive menu

def interactive_menu
  #adding arrays for students (empty to begin with) and hardcoding array of symbols for different cohorts
  possible_cohorts = [
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
  students = []
  loop do
    #1. print the menu and ask the user what they want to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    #2. read the input and save it into a variable
    selection = gets.chomp
    #3. do what the user asked
    case selection
    when "1"
      #input the students
      students = input_students(possible_cohorts)
    when "2"
      #show the students
      print_header
      print_by_cohort(students, possible_cohorts)
      print_footer(students)
    when "9"
      exit #this will cause the program to terminate
    else
      puts "I don't know what you meant, please try again"
    end
  end
end

interactive_menu
