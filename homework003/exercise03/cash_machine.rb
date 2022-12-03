class CashMachine

  BALANCE_PATH = "balance.txt"
  DEFAULT_BALANCE = 100.0

  def initialize
      if !File.exist?(BALANCE_PATH)
          File.write(BALANCE_PATH, DEFAULT_BALANCE) 
          @balance = DEFAULT_BALANCE
      else
          @balance = File.readlines(BALANCE_PATH).first.to_f
      end
  end

  def balance
      puts "Баланс: #{@balance}"
      menu()
  end
  
  def deposit()
      puts "Введите сумму депозита: "
      puts "Минимум 1"

      amount = gets.to_f

      if amount <= 0
          puts "Сумма депозита должна быть больше 0!"
          deposit()
      else
          @balance += amount
          balance()
      end
  end

  def withdraw()

      if @balance <= 0
          puts "На вашем счете нет денег." 
          menu()
      end

      puts "Введите сумму вывода: "
      puts "Минимум 1, максимум #{@balance}"

      amount = gets.to_f

      if amount > 0 && amount <= @balance
          @balance -= amount
          balance()
      else
          puts "Сумма вывода должна быть больше 0 и не больше баланса!"
          withdraw()    
      end

  end

  def quit()
      File.write(BALANCE_PATH, @balance) 
  end

  def menu()

      items = ["\"D\" - Внести деньги;", "\"W\" - Вывести деньги;", "\"B\" - Проверить баланс;", "\"Q\" - Выйти;"]

      puts "Меню: "

      items.each {|item| puts item}

      selected_index = gets.chomp

      if selected_index.upcase == 'D'
          deposit()
      elsif selected_index.upcase == 'W'
          withdraw()
      elsif selected_index.upcase == 'B'
          balance()
      elsif selected_index.upcase == 'Q' 
          quit()
      else
          puts "Введите корректную команду!"
          menu()
      end
  
  end

end

cashmachine = CashMachine.new
cashmachine.menu