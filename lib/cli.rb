class CommandLineInterface
  def greet
    "Hello, welcome to your friendly concert viewer"
  end

  def login_or_create_account
    puts "1. Login to existing account."
    puts "2. Create new account."
    input = gets.chomp
    case input
    when "1"
      login_to_account
    when "2"
      create_new_account
    else
      puts "Please enter a valid input."
      login_or_create_account
    end
  end

  def login_to_account
    puts "Enter your username"
    username = gets.chomp
    puts "Enter your password"
    password = gets.chomp
    user = User.find_by(username: username, password: password)
    if user == nil
      puts "Invalid username or password"
      sleep(1)
      login_to_account
    else
      puts "Welcome #{username}."
    end
  end

  def create_new_account
    puts "Enter a username for the new account."
    new_username = gets.chomp
    if User.find_by(username: new_username) != nil
      puts "This username is already taken, please enter another."
      create_new_account
    else
      puts "Enter a valid password."
      new_password = gets.chomp
      User.create(username: new_username, password: new_password)
    end
  end

  #   def show_options
  #     puts "1. Find or create a venue."
  #     puts "2. Find or create an artist."
  #     puts "3. Find or create a concert."
  #   end

  #   def venue_selected
  #     puts "Enter the name of a venue that you would like to find or create."
  #   end

end
