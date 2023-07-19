# 1) Predict the output:
a = "forty two"
b = "forty two"
c = a

puts a.object_id 
# -> a's object id, eg. 24
puts b.object_id 
# -> b is a different object, just with the same value (diff object id)
puts c.object_id 
# -> c points to the same object as a; eg. 24 


# 2) Predict the output:
a = 42
b = 42
c = a

puts a.object_id
# -> The integer object 42's object id; 85
puts b.object_id
# -> b points to the same integer object 42; 85
# In Ruby, there is only one Integer object for every integer value 
# because integers are immutable
puts c.object_id
# -> c also points to the same integer object as a; 85


# 3) What will be displayed?
def tricky_method(string_param_one, string_param_two)
  string_param_one += "rutabaga" # non-mutating
  string_param_two << "rutabaga" # mutating
end

string_arg_one = "pumpkins"
string_arg_two = "pumpkins"
tricky_method(string_arg_one, string_arg_two)

puts "String_arg_one looks like this now: #{string_arg_one}"
# -> String_arg_one looks like this now: pumpkins
# string_param_one is reassigned to a new string "pumpkinsrutabaga" within 
# the method - this points string_param_one to a different string than 
# string_arg_one, so the change does not persist out of the method
puts "String_arg_two looks like this now: #{string_arg_two}"
# -> String_arg_two looks like this now: pumpkinsrutabaga
# string_param_two is modified in place within the method, changing its value
# to "pumpkinsrutabaga". because string_param_two and string_arg_two are 
# still pointing to the same string, the change persists out of the method.


# 4) What will be displayed?
def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
# -> pumpkinsrutabaga
# #<< is mutating, so a_string_param and my_string continue to point at the same 
# now-modified string object
puts "My array looks like this now: #{my_array}"
# -> ['pumpkins']
# Reassignment is not mutating; an_array_param is reassigned to a different array
# ([pumpkins, rutabaga]), but the original reference (my_array) is still pointing to
# the original object ([pumpkins] array).


# 5) Depending on a method to modify its arguments can be tricky
# Methods that do not mutate their arguments are generally easier to predict 
# and maintain. How can we refactor this so that:
# my_string = 'pumpkinsrutabaga', and my_array = [pumpkins, rutabaga]
# without mutating arguments?

# def tricky_method(a_string_param, an_array_param)
#   a_string_param += "rutabaga"
#   an_array_param << "rutabaga"
# end

# my_string = "pumpkins"
# my_array = ["pumpkins"]
# tricky_method(my_string, my_array)

# puts "My string looks like this now: #{my_string}" -> pumpkins
# puts "My array looks like this now: #{my_array}" -> [pumpkins, rutabaga]
def less_tricky_method(a_string_param, an_array_param)
  a_string_param += 'rutabaga'
  an_array_param += ['rutabaga']
  [a_string_param, an_array_param]
end

my_string = 'pumpkins'
my_array = ['pumpkins']
my_string, my_array = less_tricky_method(my_string, my_array)
puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"


# 6) Simplify without changing return value:
# def color_valid(color)
#   if color == "blue" || color == "green"
#     true
#   else
#     false
#   end
# end
def color_valid?(color)
  ['blue', 'green'].include?(color)
end