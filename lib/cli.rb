class CommandLineInterface
  attr_accessor :current_user

  def greet
    "Hello, welcome to your friendly concert viewer!"
  end

  def login_or_create_account
    puts "1. Login to existing account."
    puts "2. Create new account."
    puts "3. See a list of all existing usernames."
    puts ""
    input = gets.chomp
    case input
    when "1"
      login_to_account
    when "2"
      create_new_account
    when "3"
      display_users
    else
      puts "Please enter a valid input."
      login_or_create_account
    end
  end

  def display_users
    puts ""
    User.all.each do |user|
      puts user.username
    end
    puts ""
    login_or_create_account
  end

  def login_to_account
    puts "\nEnter your username:"
    puts ""
    username = gets.chomp
    puts "Enter your password:"
    puts ""
    password = gets.chomp
    user = User.find_by(username: username, password: password)
    if user == nil
      puts "Invalid username or password."
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
    puts ""
    new_username = gets.chomp
    if User.find_by(username: new_username) != nil
      puts "This username is already taken, please enter another."
      create_new_account
    else
      puts "Enter a valid password."
      puts ""
      new_password = gets.chomp
      new_user = User.create(username: new_username, password: new_password)
      @current_user = new_user
      show_options
    end
  end

  def show_options
    # puts "1. Find artists."
    # puts "3. Find venues."
    puts "1. Find new concerts to add to your personal list."
    puts "2. Show the concerts in your list."
    puts ""
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
    puts ""
    concert_date = ""
    loop do
      concert_date = gets.chomp
      if concert_date == ""
        break
      end
      begin
        Date.strptime(concert_date, "%m/%d/%y")
      rescue ArgumentError
        puts "Invalid date. Enter a date in the format (mm/dd/yy) \n"
      else
        break
      end
    end

    puts "2. Enter a city for your concerts (or leave blank to search for concerts in all cities)."
    puts ""
    concert_city = gets.chomp
    puts "3. Enter an artist for your concerts (or leave blank to search for concerts by all artists)."
    puts ""
    concert_artist = gets.chomp
    puts "\nHere are your concerts:\n"
    concert_list = Concert.our_select(date: concert_date, city: concert_city, artist: concert_artist)
    if concert_list.empty?
      empty_return
      return
    end
    concert_list = concert_list.sort_by do |concert|
      concert.artist.name.downcase
    end
    concert_list.each_with_index do |concert, i|
      puts "#{i + 1}: #{concert.to_string}"
      puts ""
    end
    num = 0
    loop do
      puts "Enter the number of the concert you would like to add to your list."
      puts ""
      num = gets.chomp.to_i - 1
      if num < 0 || num >= concert_list.length
        puts "Invalid input. Try again."
      else
        break
      end
    end
    UserConcert.create(user_id: @current_user.id, concert_id: concert_list[num].id)
    puts "\nWould you like to view your list of concerts?"
    puts "1. View list."
    puts "2. Exit."
    puts ""
    input = gets.chomp
    if input == "1"
      list_concerts
    end
  end

  def list_concerts
    puts ""
    my_concerts = @current_user.concerts
    if my_concerts.empty?
      puts "You have no concerts saved; please add some concerts to your list and try again."
      show_options
    else
      puts ""
      @current_user.concerts.each do |concert|
        puts concert.to_string
        puts ""
      end
      puts "Would you like to remove a concert from your list?"
      puts "1. Remove a concert."
      puts "2. Return to main menu."
      puts ""
      input = gets.chomp
      case input
      when "1"
        delete_concert
      when "2"
        show_options
      else
        puts "Invalid input. Try again."
        list_concerts
      end
    end
  end

  def empty_return
    puts "Your search did not match any concerts in the database. Try again?"
    puts "1. Restart search."
    puts "2. Return to main menu"
    puts ""
    input = gets.chomp
    case input
    when "1"
      find_concert
    when "2"
      show_options
    else
      puts "Invalid input. Try again."
      empty_return
    end
  end

  def delete_concert
    my_concerts = @current_user.concerts
    my_concerts.each_with_index do |concert, i|
      puts "#{i + 1}: #{concert.to_string}"
      puts ""
    end
    puts "Please enter the number of the concert you would like to remove from your list."
    puts ""
    delete_num = gets.chomp.to_i - 1
    if delete_num < 0 || delete_num >= my_concerts.length
      puts "Invalid input. Try again."
      delete_concert
    else
      to_delete = UserConcert.find_by(user_id: @current_user.id, concert_id: my_concerts[delete_num].id)
      to_delete.destroy
      @current_user = User.find(@current_user.id)
      puts "Here is your updated concert list"
      list_concerts
    end
  end
end
