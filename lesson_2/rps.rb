
# Extract messages to .yml file
RPS_CHOICES = { rock: { wins_against: [:scissors, :lizard] },
                paper: { wins_against: [:rock, :spock] },
                scissors: { wins_against: [:paper, :lizard] },
                lizard: { wins_against: [:spock, :paper] },
                spock: { wins_against: [:scissors, :rock] } }

def prompt(message)
  puts ">> #{message}"
end

def read_name
  loop do
    prompt("What's your name?")
    input = gets.chomp
    return input unless input.empty?
    prompt("Surely you do have a name?")
  end
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

def display_score(user_score, computer_score, name)
  prompt("#{name}: #{user_score}, Computer: #{computer_score}")
end

def display_game_end(winner, name, scores)
  winning_score = scores.max
  losing_score = scores.min

  winner = winner == 'User' ? name : 'Computer'
  prompt("#{winner} wins with a score of #{winning_score}-#{losing_score}!")
end

def play_again?
  loop do
    prompt('Play again? (Y/N)')
    answer = gets.chomp.downcase
    return answer == 'y' if %w[y n].include?(answer)
    prompt('Invalid input! Please enter Y for yes or N for no.')
  end
end

system('clear')
prompt("Welcome to Rock Paper Scissors!")
name = read_name
loop do
  system('clear')
  user_score = 0
  computer_score = 0
  winner = nil

  loop do
    user_choice = read_input
    system('clear')
    computer_choice = RPS_CHOICES.keys.sample

    winner = calculate_winner(user_choice, computer_choice)

    display_result(user_choice, computer_choice, winner)

    user_score += 1 if winner == 'User'
    computer_score += 1 if winner == 'Computer'
    display_score(user_score, computer_score, name)

    break if user_score == 3 || computer_score == 3
  end

  display_game_end(winner, name, [user_score, computer_score])

  break unless play_again?
end

prompt('Thanks for playing. Goodbye!')
