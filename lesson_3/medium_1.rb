# 1) Write a one-line program that creates the following output 10 times, 
#with the subsequent line indented 1 space to the right:
# The Flintstones Rock!
#  The Flintstones Rock!
#   The Flintstones Rock!
flintstones = "The Flintstones Rock!"
10.times { |i| puts "#{" " * i}#{flintstones}"}


# 2) This code will result in an error. Why? 
# What are two ways to fix it?
# puts "the value of 40 + 2 is " + (40 + 2)

# You are attempting to add a string and an integer together;
# this will result in a TypeError (no implicit Integer->String conversion)
# 2 ways to fix this:
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"


# 3) this will fail if the input is 0, or a negative number.
# How can you make this work without using the begin/end until construct?
# * Not trying to find the factors for 0 or negative numbers.

# def factors(number)
#   divisor = number
#   factors = []
#   begin
#     factors << number / divisor if number % divisor == 0
#     divisor -= 1
#   end until divisor == 0
#   factors
# end

def factors(number)
  divisor = number
  factors = []
  while divisor.positive?
    factors << number / divisor if number.remainder(divisor).zero?
    divisor -= 1
  end
  factors
end

# What is the purpose of the number % divisor == 0 ?
# To ensure that the current divisor is only added to the factors array
#   if it does indeed result in 0 remainder (fully divisible)

# What is the purpose of the last line (factors)?
# To make sure the factors array is returned. If that line was removed, the 
# last thing to be evaluated would be the while loop, which would return nil.


# 4) Rolling buffer: if the buffer becomes full, then new elements that are added
#  will displace the oldest elements in the buffer.

# "Take your pick. Do you like << or + for modifying the buffer?"

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# #<< is mutating; #+ is not.
# The first implementation passes in the existing buffer as an argument,
# then mutates it (mutating the argument)
# Generally, if a method mutates something, it should 1) make that clear with its
# name, and 2) not return anything meaningful.

# The second implementation creates a local buffer array, then returns it.
# if the calling code does not save the return value, the buffer will be lost.


# 5) What is the error with this code? How would you fix it?
# limit = 15

# def fib(first_num, second_num)
#   while first_num + second_num < limit
#     sum = first_num + second_num
#     first_num = second_num
#     second_num = sum
#   end
#   sum
# end

# The limit variable on the second line of fib's method definition 
# is undefined within the method definition scope
# To fix this, allow a third argument to be passed in (limit)
# eg. def fib(n1, n2, limit)

# result = fib(0, 1)
# puts "result is #{result}"


# 6) What is the output of the following code?
answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8
# -> 34. numbers are immutable, so the reassignment within 
# mess_with_it only points the some_number variable to a new integer (50), which
# is then assigned to new_answer.
# But the answer variable is never reassigned, and its value is never mutated.
# Therefore, 42 - 8 => 34


# 7) Does the family's data get changed to age: age + 42, gender: 'other' ?
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)
# Yes - Why? 
# Indexed assignment is mutating (for the enclosing collection).
# each family member's age and gender are reassigned to a different object,
# so the age and gender values themselves are not mutated (only reassigned)
# but the enclosing collection IS mutated because its values are now different.


# 8) What does this code output?
# Return the winning hand
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
# puts rps(rps(paper, rock), "rock")
# puts rps(paper, "rock")
# -> "paper"


# 9) What would be the return value of bar(foo)?
def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo) # => no
# foo is called with no arguments #=> "yes"
# bar is called with param = "yes"
# param is not == "no", so "no" is returned
