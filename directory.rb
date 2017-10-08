#first we add all the studrnts to an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
#then we print them
puts "The students of Villains Academy"
puts "-------------"
students.each do |student|
  puts student
end
#finally, we print the total number of students at Villains Academy
puts "Overall, we have #{students.count} great students"
