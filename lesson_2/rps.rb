require 'yaml'
MESSAGES = YAML.load_file('rps_messages.yml')
LANGUAGE = 'en'

RPS_WINS = { rock: [:scissors, :lizard],
             paper: [:rock, :spock],
             scissors: [:paper, :lizard],
             lizard: [:spock, :paper],
             spock: [:scissors, :rock] }
WINNING_SCORE = 3

def prompt(key)
  message = MESSAGES[LANGUAGE][key] || key
  puts ">> #{message}"
end

# Inputs
def read_name
  loop do
    prompt('name?')
    input = gets.chomp
    return input unless input.strip.empty?
    prompt('invalid_name')
  end
end

def read_choice
  loop do
    prompt("Choose your weapon: #{RPS_WINS.keys.join(', ')}")
    prompt('shorthand')
    choice = gets.chomp.downcase.to_sym

    return choice if valid_choice?(choice)
    display_error(choice)
  end
end

def play_again?
  loop do
    prompt('play_again?')
    answer = gets.chomp.downcase
    return answer == 'y' if %w[y n].include?(answer)
    prompt('invalid_again')
  end
end

# Input validation & processing
def valid_choice?(input)
  RPS_WINS.keys.include?(input) || valid_shorthand?(input)
end

def valid_shorthand?(input)
  RPS_WINS.keys.one? { |key| key.start_with?(input.to_s) }
end

def convert_input(input)
  RPS_WINS.keys.find { |key| key.start_with?(input.to_s) }
end

# Game Logic
def calculate_winner(user_choice, computer_choice)
  return if tie?(user_choice, computer_choice)
  user_win?(user_choice, computer_choice) ? 'User' : 'Computer'
end

def tie?(user_choice, computer_choice)
  user_choice == computer_choice
end

def user_win?(user_choice, computer_choice)
  RPS_WINS[user_choice].include?(computer_choice)
end

def increment_score(winner, scores)
  return if winner.nil?
  scores[winner.downcase.to_sym] += 1
end

def match_end?(scores)
  scores.any? { |score| score >= WINNING_SCORE }
end

# Outputs
def display_error(user_choice)
  error_string = generate_error(user_choice)
  prompt(error_string)
end

def generate_error(input)
  matching_keys = RPS_WINS.keys.select { |key| key.start_with?(input.to_s) }

  if matching_keys.empty?
    'invalid_rps_choice'
  elsif matching_keys.size > 1
    # Create a copy to avoid mutating the original string in MESSAGES
    str = MESSAGES[LANGUAGE]['more_than_one'].dup
    str.concat(matching_keys.join("\n"))
  end
end

def display_result(user_choice, computer_choice, winner)
  prompt("You chose #{user_choice}; computer chose #{computer_choice}.")
  return prompt('tie') if winner.nil?

  prompt (winner == 'User' ? 'user_win' : 'computer_win')
end

def display_score(scores, name)
  prompt("#{name}: #{scores[:user]}, Computer: #{scores[:computer]}")
end

def display_match_end(winner, name, scores)
  winning_score = scores.max
  losing_score = scores.min

  winner = winner == 'User' ? name : 'Computer'
  prompt("#{winner} wins with a score of #{winning_score}-#{losing_score}!")
end

# Main Program Loop
prompt('welcome')
name = read_name
loop do
  system('clear')
  scores = { user: 0, computer: 0 }
  winner = nil

  loop do
    user_choice = convert_input(read_choice)
    system('clear')
    computer_choice = RPS_WINS.keys.sample

    winner = calculate_winner(user_choice, computer_choice)
    display_result(user_choice, computer_choice, winner)

    increment_score(winner, scores)
    display_score(scores, name)

    break if match_end?(scores.values)
  end

  display_match_end(winner, name, scores.values)
  break unless play_again?
end

prompt("Thanks for playing, #{name}. Goodbye!")
