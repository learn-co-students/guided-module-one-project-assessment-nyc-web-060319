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
    # puts "2. Create an artist."
    # puts "3. Find venues."
    # puts "4. Create a venue."
    puts "5. Find concerts."
    # puts "6. Create a concert."
    input = gets.chomp
    case input
    # when "1"
    #   find_artist
    # when "2"
    #   create_artist
    # when "3"
    #   find_venue
    # when "4"
    #   create_venue
    when "5"
      find_concert
      # when "6"
      #   create_concert
    end
  end

  def find_concert
    puts "1. Enter a date (mm/dd/yy) for your concerts (or leave blank to search for concerts on all dates)."
    concert_date = gets.chomp
    puts "2. Enter a city for your concerts (or leave blank to search for concerts in all cities)."
    concert_city = gets.chomp
    puts "3. Enter an artist for your concerts (or leave blank to search for concerts by all artists)."
    concert_artist = gets.chomp
    puts "\n"
    puts "Here are your concerts:"
    puts "\n"
    Concert.our_select(date: concert_date, city: concert_city, artist: concert_artist).each do |concert|
      puts concert.to_string
      puts ""
    end
  end
end
