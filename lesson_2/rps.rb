
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

def read_input
  loop do
    prompt("Choose your weapon: #{RPS_CHOICES.keys.join(', ')}")
    prompt("You can also enter a shorthand choice (eg. 'r' -> 'rock')")
    choice = gets.chomp.downcase.to_sym

    return match_input(choice) if valid_input?(choice)
    display_error(choice)
  end
end

def valid_input?(input)
  RPS_CHOICES.keys.include?(input) || valid_shorthand?(input)
end

def valid_shorthand?(input)
  RPS_CHOICES.keys.one? { |key| key.start_with?(input.to_s) }
end

def match_input(input)
  RPS_CHOICES.keys.find { |key| key.start_with?(input.to_s) }
end

def display_error(input)
  error_string = generate_error(input)
  prompt(error_string)
end

def generate_error(input)
  matching_keys = RPS_CHOICES.keys.select { |key| key.start_with?(input.to_s) }

  if matching_keys.empty?
    "That's not a valid choice!"
  elsif matching_keys.size > 1
    str = "Sorry, that wasn't clear enough. Did you mean one of these?\n"
    matching_keys.each { |key| str.concat(key.to_s, "\n") }
    str
  end
end

def display_result(user_choice, computer_choice, winner)
  prompt("You chose #{user_choice}; computer chose #{computer_choice}.")
  return prompt("It's a tie :|") if winner.nil?

  prompt (winner == 'User') ? 'You win! :)' : 'Computer wins :(' 
end

def calculate_winner(user_choice, computer_choice)
  return if tie?(user_choice, computer_choice)
  user_win?(user_choice, computer_choice) ? 'User' : 'Computer'
end

def tie?(user_choice, computer_choice)
  user_choice == computer_choice
end

def user_win?(user_choice, computer_choice)
  RPS_CHOICES[user_choice][:wins_against].include?(computer_choice)
end

def increment_score(result, user_score, computer_score)
  
end

loop do
  system('clear')
  user_score = 0
  computer_score = 0

  loop do
    # get input -> user choice
    user_choice = read_input
    # generate computer choice
    computer_choice = RPS_CHOICES.keys.sample
    # calculate the result
    winner = calculate_winner(user_choice, computer_choice)
    # display the result
    display_result(user_choice, computer_choice, winner)
    # increment either player score or computer score, 
    #   based on the result (who won)
    increment_score(winner, user_score, computer_score)
    #numbers are immutable

    # if either player/computer score == 3, break loop
    # and display the winner
    # then ask if user wants to play again


    break if user_score == 3 || computer_score == 3
  end
end



# loop do
#   system('clear')

#   choice = read_input
#   computer = RPS_CHOICES.keys.sample

#   display_result(choice, computer)

#   prompt('Play again? (Y/N)')
#   answer = gets.chomp
#   break unless answer.downcase == 'y'
# end

# prompt('Thanks for playing. Goodbye!')
