class CommandLineInterface
  attr_accessor :current_user

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
      @current_user = user
      show_options
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

  def show_options
    # puts "1. Find artists."
    # puts "3. Find venues."
    puts "1. Find new concerts to add to your personal list."
    puts "2. Show the concerts in your list."
    input = gets.chomp
    case input
    when "1"
      find_concert
    when "2"
      list_concerts
    else
      puts "Invalid input, please try again."
      puts ""
      show_options
    end
  end

  def find_concert
    puts "1. Enter a date (mm/dd/yy) for your concerts (or leave blank to search for concerts on all dates)."
    concert_date = gets.chomp
    puts "2. Enter a city for your concerts (or leave blank to search for concerts in all cities)."
    concert_city = gets.chomp
    puts "3. Enter an artist for your concerts (or leave blank to search for concerts by all artists)."
    concert_artist = gets.chomp
    puts "\nHere are your concerts:\n"
    concert_list = Concert.our_select(date: concert_date, city: concert_city, artist: concert_artist)
    if concert_list.empty?
      empty_return
      return
    end
    concert_list.each_with_index do |concert, i|
      puts "#{i + 1}: #{concert.to_string}"
      puts ""
    end
    puts "Enter the number of the concert you would like to add to your list"
    num = gets.chomp.to_i
    UserConcert.create(user_id: @current_user.id, concert_id: concert_list[num - 1].id)
    puts "\n Would you like to view your list of concerts?"
    puts "1. View list."
    puts "2. Exit."
    input = gets.chomp
    if input == "1"
      list_concerts
    end
  end

  def list_concerts
    puts ""
    @current_user.concerts.each do |concert|
      puts concert.to_string
      puts ""
    end
  end

  def empty_return
    puts "Your search did not match any concerts in the database. Try again?"
    puts "1. Restart search."
    puts "2. Return to main menu"
    input = gets.chomp
    case input
    when "1"
      find_concert
    when "2"
      show_options
    else
      puts "Invalid input."
      empty_return
    end
  end
end
