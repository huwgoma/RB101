# Ask user to choose (RPS)
# Computer chooses
# Display result
# Ask if play again
# RPS_CHOICES = ['rock', 'paper', 'scissors']
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

loop do
  system('clear')
  choice = nil
  loop do
    prompt("Choose your throw: #{RPS_CHOICES.keys.join(', ')}")
    choice = gets.chomp.downcase.to_sym
    break if RPS_CHOICES.keys.include?(choice)
    prompt("That's not a valid choice!")
  end

  computer = RPS_CHOICES.keys.sample

  display_result(choice, computer)

  prompt('Play again? (Y/N)')
  answer = gets.chomp
  break unless answer.downcase == 'y'
end

prompt('Thanks for playing. Goodbye!')
