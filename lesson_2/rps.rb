require 'yaml'
MESSAGES = YAML.load_file('rps_messages.yml')
LANGUAGE = 'en'

RPS_CHOICES = { rock: { wins_against: [:scissors, :lizard] },
                paper: { wins_against: [:rock, :spock] },
                scissors: { wins_against: [:paper, :lizard] },
                lizard: { wins_against: [:spock, :paper] },
                spock: { wins_against: [:scissors, :rock] } }

def prompt(key)
  message = MESSAGES[LANGUAGE][key] || key
  puts ">> #{message}"
end

# Inputs
def read_name
  loop do
    prompt('name?')
    input = gets.chomp
    return input unless input.empty?
    prompt('invalid_name')
  end
end

def read_choice
  loop do
    prompt("Choose your weapon: #{RPS_CHOICES.keys.join(', ')}")
    prompt('shorthand')
    choice = gets.chomp.downcase.to_sym

    return match_input(choice) if valid_choice?(choice)
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
  RPS_CHOICES.keys.include?(input) || valid_shorthand?(input)
end

def valid_shorthand?(input)
  RPS_CHOICES.keys.one? { |key| key.start_with?(input.to_s) }
end

def match_input(input)
  RPS_CHOICES.keys.find { |key| key.start_with?(input.to_s) }
end

# Winner Logic
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

# Outputs
def display_error(input)
  error_string = generate_error(input)
  prompt(error_string)
end

def generate_error(input)
  matching_keys = RPS_CHOICES.keys.select { |key| key.start_with?(input.to_s) }

  if matching_keys.empty?
    'invalid_rps_choice'
  elsif matching_keys.size > 1
    # Create a copy to avoid mutating the actual string in MESSAGES
    str = MESSAGES[LANGUAGE]['more_than_one'].dup
    str.concat(matching_keys.join("\n"))
  end
end

def display_result(user_choice, computer_choice, winner)
  prompt("You chose #{user_choice}; computer chose #{computer_choice}.")
  return prompt('tie') if winner.nil?

  prompt winner == 'User' ? 'user_win' : 'computer_win'
end

def display_score(scores, name)
  prompt("#{name}: #{scores[:user]}, Computer: #{scores[:computer]}")
end

def display_game_end(winner, name, scores)
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
    user_choice = read_choice
    system('clear')
    computer_choice = RPS_CHOICES.keys.sample

    winner = calculate_winner(user_choice, computer_choice)
    display_result(user_choice, computer_choice, winner)

    scores[winner.downcase.to_sym] += 1 unless winner.nil?
    display_score(scores, name)

    break if scores.values.any? { |score| score >= 3 }
  end

  display_game_end(winner, name, scores.values)
  break unless play_again?
end

prompt("Thanks for playing, #{name}. Goodbye!")
