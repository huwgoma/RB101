# 1) What would you expect the code below to print out?
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

#-> 1 2 2 3 (Newline-separated)


# 2) Describe the difference between ! and ? in Ruby. 
# ! is the unary 'NOT' operator. It inverts the truthiness/falsiness of its operand,
# returning false for truthy objects and true for falsy objects.
# ! can also be suffixed to method names to indicate the method is destructive,
# although this is by convention only and not a language feature.

# ? is part of the ternary operator: some_condition ? value_if_true : value_if_false
# ? marks the end of the conditional expression in the ternary syntax.
# ? can also be suffixed to method names to indicate the method will return a Boolean,
# although again this is only by convention.
# ? can be prefixed to a single character or an escape sequence to return a 
# corresponding string (eg. ?n => "n"; ?\n => "\n")

# And explain what would happen in the following scenarios:
# what is != and where should you use it?
#  != is the 'NOT EQUAL TO' operator. Use it when you want to check that two
#  operands are not equal (type and value). 

# put ! before something, like !user_name
#  !user_name will return true if user_name is nil or false;
#  otherwise it will return false.

# put ! after something, like words.uniq!
#  Nothing will happen -because- of the ! specifically; #uniq! is defined to be 
#  destructive, so it will mutate and return the calling array.

# put ? before something
#  If 'something' is a single character or an escape character, returns a 
#  corresponding string (eg. ?n => "n"); otherwise, raises a SyntaxError

# put ? after something
#  Nothing will happen specifically because of the ?, but by convention, 
#  methods ending with ? will return true or false.

# put !! before something, like !!user_name
#  Returns true if user_name is a truthy value, and false otherwise.


# 3) Replace the word "important" with "urgent" in this string:
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!('important', 'urgent') # Mutating


# 4) The Ruby Array class has several methods for removing items from the array. 
# Two of them have very similar names. Let's see how they differ:
# What do the following method calls do (assume we reset numbers to the 
# original array between method calls)?
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1)
# Delete the element AT index 1
# numbers => [1, 3, 4, 5]

numbers = [1, 2, 3, 4, 5]
numbers.delete(1)
# Delete all elements with the value 1
# numbers => [2, 3, 4, 5]


# 5) Programmatically determine if 42 lies between 10 and 100.
# Use Ruby's range object in your solution.
(10..100).include?(42)
# include? and cover? behave the same if arguments are numeric.
42.between?(10, 100)


# 6) Show two different ways to put the expected "Four score and " 
# in front of this string.
famous_words = "seven years ago..."
more_words = "Four score and "

# puts famous_words.insert(0, more_words) 
famous_words.prepend(more_words) # famous_words is mutated
famous_words = "seven years ago..."
more_words.concat(famous_words) # famous_words is mutated again


# 7) Building an array like this will create a nested array:
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
# flintstones => ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
# Make this into an unnested array.
flintstones.flatten!


# 8) Given this hash, create an array with 2 elements: Barney's name and number
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones.assoc('Barney')