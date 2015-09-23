# basic calculator, no error checking for enter nonnumerical input
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def add(number1, number2)
  number1.to_i + number2.to_i
end

def subtract(number1, number2)
   number1.to_i - number2.to_i
end

def divide(number1, number2)
  number1.to_f / number.to_f
end

def multiply(number1, number2)
   number1.to_i * number2.to_i
end

def get_number_again
  begin
    puts "Please enter a valid number!"
    input = gets.chomp.downcase
    exit if input == 'exit' 
  end until input.numeric?
  input
end

puts "Welcome to the calculator.  Type 'exit' at any time to quit"
puts "Press enter to continue"
gets
loop do
puts "Enter the first number"
first_number = gets.chomp.downcase
exit if first_number == 'exit'
first_number = get_number_again if !first_number.numeric?
puts "Enter the second number"
second_number = gets.chomp.downcase
exit if second_number == 'exit'
second_number = get_number_again if !second_number.numeric?
begin
puts "Please choose one of the following options (1-4)"
puts "1) Add, 2) Subtract, 3) Divide, 4) Multiply"
answer = gets.chomp.downcase
exit if answer == 'exit'
case answer
  when "1" then puts "#{first_number} plus #{second_number} is #{add(first_number, second_number)}"
  when "2" then puts "#{first_number} minus #{second_number} is #{subtract(first_number, second_number)}"
  when "3" then puts "#{first_number} divided by #{second_number} is #{divide(first_number, second_number)}"
  when "4" then puts "#{first_number} times #{second_number} is #{multiply(first_number, second_number)}"
  else
    puts "Not a valid option.  Try again!"
    next
  end
end until ["1","2","3","4"].include?(answer)
end
