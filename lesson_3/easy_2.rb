# 1) See if "Spot" is present (3 ways)
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages["Spot"] #=> nil
ages.has_key?('Spot') #=> false
ages.any? { |k, _v| k == 'Spot' } #=> false


# 2) Convert this string to the following strings:
munsters_description = "The Munsters are creepy in a good way."
# Operations are non-destructive so I don't have to reset it each time:
munsters_description.swapcase
# => "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
munsters_description.capitalize 
# => "The munsters are creepy in a good way."
munsters_description.downcase
# "the munsters are creepy in a good way."
munsters_description.upcase
# "THE MUNSTERS ARE CREEPY IN A GOOD WAY."


# 3) Add ages for Marilyn and Spot to the existing hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)


# 4) See if the name "Dino" appears in the string below:
advice = "Few things in life are as important as house training your pet dinosaur."
advice.include?("Dino")
advice.match?("Dino")


# 5) Show an easier way to write this array:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones = %w[Fred Barney Wilma Betty BamBam Pebbles]


# 6) How can we add the family pet "Dino" to our usual array:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"


# 7) How can we add multiple items to our array? (Dino and Hoppy)
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.concat(['Dino', 'Hoppy'])
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push('Dino', 'Hoppy')


# 8) Shorten the following sentence:
advice = "Few things in life are as important as house training your pet dinosaur."
# Return: "Few things in life are as important as "
# advice => "house training your pet dinosaur."
advice.slice!("Few things in life are as important as ")
# As a bonus, what happens if you use the String#slice method instead?
# advice would not be mutated (so it would still point to the full sentence)


# 9) Write a one-liner to count the number of lower-case 't' characters 
# in the following string:
statement = "The Flintstones Rock!"
statement.count('t')


# 10) Back in the stone age (before CSS) we used spaces to align things 
# on the screen. If we had a table of Flintstone family members that was forty 
# characters in width, how could we easily center that title above the table with 
# spaces?
table_width = 40
title = "Flintstone Family Members"
title.center(table_width)