require 'yaml'
MESSAGES = YAML.load_file('loan_calculator_messages.yml')
LANGUAGE = 'en'

def prompt(key, lang='en')
  message = MESSAGES[lang][key] || key
  puts ">> #{message}"
end

def numeric?(str)
  !!(Integer(str) rescue false || Float(str) rescue false)
end

def read_input(message)
  loop do
    prompt(message)
    input = gets.chomp
    return input if valid_input?(input, message)
  end
end

def read_duration_input(message)
  loop do
    input = {}
    prompt(message)
    prompt('loan_years')
    input[:years] = gets.chomp
    prompt('loan_months')
    input[:months] = gets.chomp
    return input if valid_input?(input, message)
  end
end

def valid_input?(input, message)
  case message
  when 'loan_amount' then valid_loan_amount?(input)
  when 'yearly_interest' then valid_interest?(input)
  when 'loan_duration' then valid_loan_duration?(input)
  end
end

def valid_loan_amount?(input)
  return prompt('valid_number') unless numeric?(input)
  return prompt('loan_amount_zero') unless input.to_f.positive?
  true
end

def valid_interest?(input)
  return prompt('valid_number') unless numeric?(input)
  return prompt('interest_negative') if input.to_f.negative?
  true
end

def valid_loan_duration?(input)
  unless numeric?(input[:years]) && numeric?(input[:months])
    return prompt('valid_number')
  end
  values = input.values.map(&:to_i)
  return prompt('loan_duration_negative') if values.any?(&:negative?)
  return prompt('loan_duration_zero') if values.none?(&:positive?)
  true
end

def calculate_monthly_payment(amount, monthly_interest, months)
  return amount / months if monthly_interest.zero?
  amount * (monthly_interest / (1 - (1 + monthly_interest)**(-months)))
end

def calculate_again?
  loop do
    prompt('calculate_again')
    input = gets.chomp.downcase
    return input == 'y' if ['y', 'n'].include?(input)
    prompt('again_invalid')
  end
end

loop do
  system('clear')
  # Inputs
  amount = read_input('loan_amount').to_f

  yearly_interest = read_input('yearly_interest').to_f
  monthly_interest = yearly_interest / 100 / 12

  duration = read_duration_input('loan_duration').transform_values(&:to_i)
  duration_in_months = (duration[:years] * 12) + duration[:months]

  # Outputs
  monthly_payment = calculate_monthly_payment(amount,
                                              monthly_interest,
                                              duration_in_months).round(2)
  prompt('calculating')
  sleep 0.5
  output_message = <<-HEREDOC
Given a loan amount of $#{amount},
   a yearly interest rate of #{yearly_interest}%,
   and a loan duration of #{duration[:years]} years, #{duration[:months]} months:

   Your monthly payments will be $#{monthly_payment}.
  HEREDOC
  prompt(output_message)

  # Again?
  break unless calculate_again?
end

prompt('goodbye')
