require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, language='en')
  MESSAGES[language][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  message = key if message.nil?
  puts ">> #{message}"
end

def numeric?(str)
  !!(Integer(str) rescue false || Float(str) rescue false)
end

def operation_message(op)
  { '1' => 'Adding',
    '2' => 'Subtracting',
    '3' => 'Multiplying',
    '4' => 'Dividing' }[op]
end

def read_number(count: 1)
  ordinal = (count == 2) ? 'second ' : ''
  input = nil
  loop do
    prompt("Please enter a #{ordinal}number.")
    input = gets.chomp
    return input if numeric?(input)
    prompt('valid_number')
  end
end

prompt('welcome')
name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt('valid_name')
  else
    break
  end
end

prompt("Hi #{name}!")

loop do
  number1 = read_number
  number2 = read_number(count: 2)

  prompt('op_prompt')

  operator = nil
  loop do
    operator = gets.chomp
    break if ['1', '2', '3', '4'].include?(operator)
    prompt('valid_op')
  end

  prompt("#{operation_message(operator)} #{number1} and #{number2}...")

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}.")

  prompt('calculate_again')
  again = gets.chomp
  break unless again.downcase.start_with?('y')
end

prompt('thank_you')
