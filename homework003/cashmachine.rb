DEFAULT_BALANCE = 100.0
BALANCE_FILE_PATH = "balance.txt"

def show_tips
  puts 'Команда "D" для зачисления средств на счет'
  puts 'Команда "W" для вывода средств'
  puts 'Команда "B" для отображения баланса'
  puts 'Команда "Q" для выхода'
  puts "Введите команду:"
end

def show_error(message)
  puts "Ошибка! #{message}"
end

def show_balance(current_balance)
  puts "Ваш текущий баланс: #{current_balance}"
end

def deposite(current_balance)
  puts 'Введите сумму, которую хотите внести на Ваш счет, либо "Q" для отмены операции. Сумма должна быть больше 0:'
  input = gets.chomp
  return current_balance if input.upcase == "Q"
  money = input.to_f
  if money > 0.0
    current_balance += money
    show_balance(current_balance)
  else
    show_error("Для занесения на счет укажите положительное число!")
    current_balance = deposite(current_balance)
  end
  return current_balance
end

def withdraw(current_balance)
  puts 'Введите сумму, которую хотите снять с Вашего счета, либо "Q" для отмены операции.
Сумма должна быть больше 0 и не превышать вашего текущего баланса:'
  input = gets.chomp
  return current_balance if input.upcase == "Q"
  money = input.to_f
  case
  when money > 0.0 && money <= current_balance
    current_balance -= money
    show_balance(current_balance)
  when money > current_balance
    show_error("Запрошенная сумма превышает Ваш текущий баланс!")
    current_balance = withdraw(current_balance)
  else
    show_error("Для снятия средств укажите положительное число!")
    current_balance = withdraw(current_balance)
  end
  return current_balance
end

File.exists?(BALANCE_FILE_PATH) ? current_balance = File.read(BALANCE_FILE_PATH).chomp.to_f : current_balance = DEFAULT_BALANCE

puts "Добро пожаловать на Ваш банковский счет!"
loop do
  show_tips
  command = gets.chomp.upcase
  case command
  when "B"
    show_balance(current_balance)
  when "D"
    current_balance = deposite(current_balance)
  when "W"
    current_balance = withdraw(current_balance)
  when "Q"
    puts "Ваши финансы очень важны для нас. До свидания!"
    break
  else
    show_error("Введена неправильная команда!")
  end
end

File.write(BALANCE_FILE_PATH, current_balance)