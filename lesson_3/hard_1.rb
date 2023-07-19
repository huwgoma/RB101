# 1) What happens when greeting is referenced on the last line?
# if false
#   greeting = "hello world"
# end

# greeting 

# greeting will be nil. No undefined method/variable error is raised. Why?
#   Before execution, Ruby parses the code and initializes all variables with
# a value of nil, regardless of whether they will be encountered during execution.
#   During execution, all variables are nil until they are otherwise assigned.
# So, even though the assignment (greeting = 'hello world') never happens, the 
# greeting variable IS initialized, and it keeps its value of nil when it is 
# referenced.


# 2) What is the result of the last line in the code below?
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings 
# -> { a: 'hi there' }


# 3) What will each of these print?
# A)
def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" #-> one
puts "two is: #{two}" #-> two
puts "three is: #{three}" #-> three
# All mess_with_vars is doing is reassigning its own local one/two/three variables
# to each other; the original string objects are not mutated.

# B)
def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" #-> one
puts "two is: #{two}" #-> two
puts "three is: #{three}" #-> three
# Same as above; mess_with_vars is reassigning its local variables to new String
# objects; the original String objects are not mutated.

# C) 
def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" #-> two
puts "two is: #{two}" #-> three
puts "three is: #{three}" #-> one
# String#gsub! is a mutating method. Each of the original String objects is
# modified in place by mess_with_vars; that change will persist out of the method.


# 4) This method has a few issues:
# No false condition is being returned
# The case where input has >4< components is not handled
#   eg. "4.5.5" (3) and "1.2.3.4.5" (5) should be invalid. 
#   eg. "10.4.5.11" is a valid IP address (4 dot-separated number strings)

# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     break unless is_an_ip_number?(word)
#   end
#   return true
# end

# Input: input string, dot-separated
# Output: true (splits into 4 (on dots), all 4 0-255), false otherwise

# Separate the input string on dots, save into an array variable
#   If the array's size is not exactly 4, return false
# Otherwise, iterate through the array of split strings. for each:
#   check if the current string is an ip number?(between 0-255).
#   if it is, continue iterating.
#   if it is not, break the loop and return false (all strings must be 0-255)
# If the end of the array is reached, all strings are 0-255. Return true.

# Modifying as little as possible:
# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split('.')
#   return false unless dot_separated_strings.size == 4
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     return false unless is_an_ip_number?(word)
#   end
#   true
# end

# How I would do it?
# def dot_separated_ip_address?(input_string)
#   dot_separated_strings = input_string.split('.')
#   return false unless dot_separated_strings.size == 4

#   dot_separated_strings.all? { |string| is_an_ip_number?(string) }
# end
  