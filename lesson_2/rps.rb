# Allow the user to (optionally) type shorthand version
# while maintaining ability to type full version
# eg. 'r' or 'rock' -> :rock
# edge: 's' -> spock or scissors?
#       'sc' or 'scissors' -> :scissors
#       'sp' or 'spock' -> :spock
# Expand validation method to allow shorthand too
# If input is shorthand, will need to convert to full 
# 1) get input from user; downcase and convert to symbol
# 2) break input validation loop if the input is a valid one.
#   - What counts as a valid_input?
#     - If the input is included in rps keys (rock paper scissors lizard spock)
#     - OR if any of the rps keys STARTS WITH the input 
#        - Edge case 's': (Any input where there are multiple possible fulls)
#           "Sorry, that was unclear. Do you mean:
#             - spock?
#             - scissors? "
#           = Update OR condition: If ONE and exactly one rps key
#             starts with the input
#           If none start with the input: That doesn't look like a valid choice sry
#           If more than one: Sorry, there are multiple possible options idk
#              Print all the options that do start with the input




# Keeping score (best of 5)

# Welcome message
# Input validation for exit loop
# Extract messages to .yml file
RPS_CHOICES = { rock: { wins_against: [:scissors, :lizard] },
                paper: { wins_against: [:rock, :spock] },
                scissors: { wins_against: [:paper, :lizard] },
                lizard: { wins_against: [:spock, :paper] },
                spock: { wins_against: [:scissors, :rock] } }

def prompt(message)
  puts ">> #{message}"
end

def display_result(choice, computer)
  result = calculate_result(choice, computer)
  prompt("You chose #{choice}; computer chose #{computer}.")
  prompt(result)
end

def calculate_result(choice, computer)
  return "Tie!" if choice == computer
  if RPS_CHOICES[computer][:wins_against].include?(choice)
    "Computer wins!"
  elsif RPS_CHOICES[choice][:wins_against].include?(computer)
    "You win!"
  end
end

def valid_input?(input)
  RPS_CHOICES.keys.include?(input) || valid_shorthand?(input)
end

def valid_shorthand?(input)
  RPS_CHOICES.keys.one? { |key| key.start_with?(input.to_s) }
end

def expand_input(input)
  RPS_CHOICES.keys.find { |key| key.start_with?(input.to_s) }
end

def display_error()

end

loop do
  system('clear')
  choice = nil
  loop do
    prompt("Choose your throw: #{RPS_CHOICES.keys.join(', ')}")
    choice = gets.chomp.downcase.to_sym
    if valid_input?(choice)
      choice = expand_input(choice)
      break
    end
    prompt("That's not a valid choice!")
  end

  computer = RPS_CHOICES.keys.sample

  display_result(choice, computer)

  prompt('Play again? (Y/N)')
  answer = gets.chomp
  break unless answer.downcase == 'y'
end

prompt('Thanks for playing. Goodbye!')
