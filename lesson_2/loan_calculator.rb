require 'yaml'
MESSAGES = YAML.load_file('loan_calculator_messages.yml')
LANGUAGE = 'en'
# Car Payment Calculator
# You need to take out a loan to buy a car.
# How much do you pay back each month?
# Problem:
#   Inputs: Loan Amount (Float)
#           Annual Percentage Rate (Also a Float)
#           Loan duration (In months - Integer)   
#   Outputs: Monthly interest rate (Float)
#            Loan duration (In months, Integer)
#            Monthly payment (Float)     
#   Rules: Interest cannot be 0. (If interest is 0, loan amount / loan duration (?))
#          Loan duration must be at least 1.
#          Loan amount must be greater than 0. 


# monthly payment = 
# loan amount * (interest (monthly) / (1 - (1 + interest(monthly))**(- months)))
# Interest rates are in terms of years; so to get monthly interest rate,
# you need to divide by 12.


# Examples: 
# $1000 loan, APR 6%, 2 years and 2 months to pay back.
# Monthly interest rate: 0.06 / 12 => 0.005
# Loan duration: 2 * 12 + 2 => 26 months
# Monthly payment: 41.11 (using that formula)

# Data Structures:
# No data structures? -> Data
# APR Input needs to be converted a percentage (yearly), 
# then to a Monthly Interest Rate
# Loan duration should be solicited in months

# Algorithm:
# Ask the user for input: 
#   - Loan Amount, in dollars. (eg. 1000.00) 
#   - Yearly interest rate, in %. (eg. 6%)
#   - Loan duration, in years and months. (eg. Years: 2, Months: 2) 


# Convert loan amount to a float
# Convert loan years + months to only months (years * 12 + months)
# Convert yearly interest rate to a percentage decimal (Convert to a float, /100)
# Convert yearly interest rate to MONTHLY INTEREST RATE. (/12)

# Calculate the monthly payment using the given formula.
# Example Output:
# Given a loan amount of $1000, a yearly interest rate of 6%, and a loan duration of 
# 2 years and 2 months:
# The monthly interest rate is 0.5% (0.005).
# The loan duration (in months) is 26 months.
# The monthly payment is $41.11.

# Edge Cases:
# If loan amount is 0 or negative, invalid input.
# If interest is 0, monthly payment is equal to loan amount / loan duration (months)
# If loan duration is less than 1, invalid input.

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
    return input.to_f if valid_input?(input, message)
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
    return input.transform_values(&:to_i) if valid_input?(input, message)
  end
end

# (Validate all of these inputs separately.)
# Validate Loan Amount:
#   - Is the input a number? 
#     - No -> "That doesn't look like a number."
#     - Yes -> Is the input positive?
#       - No -> "Can't be 0."

# Validate Interest:
#   - Is input numeric? No -> Not a number; 
#                       Yes -> Is input negative?
#                              -> No: Good. -> Yes: 'Can't be negative.

# Validate Loan duration (Get both before validating):
#   - Are both inputs numeric? No -> NaN;
#                              Yes -> Is either input negative? -> Yes: Cant be neg
#                                     Is at least one input positive?
#
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
  values = input.values
  return prompt('valid_number') unless values.all? { |v| numeric?(v) }
  values.map!(&:to_i)
  return prompt('loan_duration_negative') if values.any?(&:negative?)
  return prompt('loan_duration_zero') if values.none?(&:positive?)
  true
end





def calculate_monthly_payment(loan_amount, monthly_interest, loan_duration)
  loan_amount * (monthly_interest / (1 - (1 + monthly_interest)**(-(loan_duration))))
end





# Inputs
loan_amount = read_input('loan_amount')

yearly_interest = read_input('yearly_interest')
monthly_interest = yearly_interest / 100 / 12

loan_duration = read_duration_input('loan_duration')
loan_duration_in_months = loan_duration[:years] * 12 + loan_duration[:months]

monthly_payment = calculate_monthly_payment(loan_amount, monthly_interest, loan_duration_in_months).round(2)

output_message = <<-HEREDOC
  Given a loan amount of $#{loan_amount}, 
     a yearly interest rate of #{yearly_interest}%,
     and a loan duration of #{loan_duration[:years]} years, #{loan_duration[:months]} months:

  Your monthly payments will be $#{monthly_payment}.
HEREDOC
prompt(output_message)
