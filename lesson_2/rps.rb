# Ask user to choose (RPS)
# Computer chooses
# Display result
# Ask if play again
# RPS_CHOICES = ['rock', 'paper', 'scissors']
RPS_CHOICES = { rock: { wins_against: :scissors, loses_to: :paper },
                paper: { wins_against: :rock, loses_to: :scissors },
                scissors: { wins_against: :paper, loses_to: :rock } }

def test_method
  prompt('test')
end

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

  if computer == RPS_CHOICES[choice][:loses_to]
    "Computer wins!"
  elsif computer == RPS_CHOICES[choice][:wins_against]
    "You win!"
  end
end

loop do
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
