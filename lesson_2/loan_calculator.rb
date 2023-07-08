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
  end
end

def valid_loan_amount?(input)
  return prompt('valid_number') unless numeric?(input)
  return prompt('loan_amount_zero') unless input.to_f.positive?
  true
end





def calculate_monthly_payment(loan_amount, annual_interest, loan_duration)

end





# Loan Amount
loan_amount = read_input('loan_amount')
p loan_amount
  

  # prompt('yearly_interest')
  # yearly_interest = gets.chomp # Must be numeric; convert to float
  # prompt('loan_duration')
  # prompt('loan_years')
  # loan_years = gets.chomp # Must be numeric; convert to int
  # prompt('loan_months')
  # loan_months = gets.chomp # Must be numeric; convert to int



# puts "Given a loan amount of #{loan_amount}, a yearly interest rate of #{yearly_interest}" +
#     ", and a loan duration of #{loan_years}, #{loan_months}:"