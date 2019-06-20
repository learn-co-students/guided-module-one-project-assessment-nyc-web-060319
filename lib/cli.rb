class CommandLineInterface
  attr_accessor :current_user

  def greet
    puts "\nHello, welcome to your friendly concert viewer!".light_blue
  end

  def login_or_create_account
    prompt = TTY::Prompt.new
    input = prompt.select("Choose an option") do |menu|
      menu.choice "Login to existing account.", "1"
      menu.choice "Create new account.", "2"
      menu.choice "See a list of all existing usernames.", "3"
    end
    case input
    when "1"
      login_to_account
    when "2"
      create_new_account
    when "3"
      display_users
    else
      puts "Please enter a valid input.".red
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
      puts "Invalid username or password.".red
      sleep(1)
      puts ""
      login_or_create_account
    else
      @current_user = user
      puts "\nWelcome, #{@current_user.username}!".green
      show_options
    end
  end

  def create_new_account
    puts "Enter a username for the new account."
    puts ""
    new_username = gets.chomp
    if new_username == ""
      puts "Please enter a non-blank username.".red
      create_new_account
    elsif User.find_by(username: new_username) != nil
      puts "This username is already taken, please enter another.".red
      create_new_account
    else
      puts "Enter a password."
      puts ""
      new_password = gets.chomp
      new_user = User.create(username: new_username, password: new_password)
      @current_user = new_user
      puts "Welcome, #{@current_user.username}"
      show_options
    end
  end

  def show_options
    prompt = TTY::Prompt.new
    input = prompt.select("Choose an option") do |menu|
      menu.choice "Find new concerts to add to your personal list.", "1"
      menu.choice "Show the concerts in your list.", "2"
      menu.choice "Exit the program.", "3"
    end

    case input
    when "1"
      find_concert
    when "2"
      list_concerts
    when "3"
      return
    else
      puts "Invalid input, please try again.".red
      puts ""
      show_options
    end
  end

  def input_date
    concert_date = ""
    loop do
      concert_date = gets.chomp
      break if concert_date == ""

      begin
        Date.strptime(concert_date, "%m/%d/%y")
      rescue ArgumentError
        puts "Invalid date. Enter a date in the format (mm/dd/yy) \n".red
      else
        break
      end
    end
    concert_date
  end

  def print_found_concerts(concert_list)
    concert_list.each_with_index do |concert, i|
      puts "#{i + 1}: #{concert.to_string}".green
      puts ""
    end
  end

  def pick_concert_to_add(concert_list)
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
    poss_dups = UserConcert.where(user_id: @current_user.id, concert_id: concert_list[num].id)
    if poss_dups.size > 0
      puts "That concert is already in your list. Taking you back to the selection screen".red
      find_concert
    else
      UserConcert.create(user_id: @current_user.id, concert_id: concert_list[num].id)
      choose_to_view_list
    end
  end

  def choose_to_view_list
    puts "\nWould you like to view your list of concerts?"
    puts "1. View list."
    puts "2. Exit.".red
    puts ""
    input = gets.chomp
    case input
    when "1"
      list_concerts
    when "2"
      return
    else
      puts "Invalid input.".red
      choose_to_view_list
    end
  end

  def find_concert
    puts "1. Enter a date (mm/dd/yy) for your concerts (or leave blank to search for concerts on all dates)."
    puts ""
    concert_date = input_date

    puts "2. Enter a city for your concerts (or leave blank to search for concerts in all cities)."
    puts ""
    concert_city = gets.chomp
    puts "3. Enter an artist for your concerts (or leave blank to search for concerts by all artists)."
    puts ""
    concert_artist = gets.chomp
    concert_list = Concert.our_select(date: concert_date, city: concert_city, artist: concert_artist)
    if concert_list.empty?
      empty_return
      return
    end

    concert_list = concert_list.sort_by do |concert|
      concert.artist.name.downcase
    end

    puts "\nHere are your concerts:\n"
    print_found_concerts(concert_list)
    decision_to_add(concert_list)
  end

  def decision_to_add(concert_list)
    puts "Would you like to add one of these concerts to your list?"
    puts "1. Yes."
    puts "2. No."
    yes_or_no = gets.chomp
    case yes_or_no
    when "1"
      pick_concert_to_add(concert_list)
    when "2"
      show_options
    else
      puts "Invalid input."
      decision_to_add(concert_list)
    end
  end

  def list_concerts
    my_concerts = @current_user.concerts
    @current_user = User.find(@current_user.id)
    puts ""
    if my_concerts.empty?
      puts "You have no concerts saved; please add some concerts to your list and try again.".red
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
        puts "Invalid input. Try again.".red
        list_concerts
      end
    end
  end

  def empty_return
    puts "Your search did not match any concerts in the database. Try again?".red
    puts "1. Restart search."
    puts "2. Return to main menu."
    puts ""
    input = gets.chomp
    case input
    when "1"
      find_concert
    when "2"
      show_options
    else
      puts "Invalid input. Try again.".red
      empty_return
    end
  end

  def delete_concert
    @current_user = User.find(@current_user.id)
    my_concerts = @current_user.concerts
    my_concerts.each_with_index do |concert, i|
      puts "#{i + 1}: #{concert.to_string}"
      puts ""
    end
    puts "Please enter the number of the concert you would like to remove from your list."
    puts ""
    delete_num = gets.chomp.to_i - 1
    if delete_num < 0 || delete_num >= my_concerts.length
      puts "Invalid input. Try again.".red
      delete_concert
    else
      to_delete = UserConcert.find_by(user_id: @current_user.id, concert_id: my_concerts[delete_num].id)
      to_delete.destroy
      @current_user = User.find(@current_user.id)
      puts "Here is your updated concert list."
      list_concerts
    end
  end
end
