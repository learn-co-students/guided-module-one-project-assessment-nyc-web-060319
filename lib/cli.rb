class CommandLineInterface
  attr_accessor :current_user

  def greet
    puts "\nHello, welcome to your friendly concert viewer!".light_blue
    puts AsciiArt.guitar
  end

  def login_or_create_account
    prompt = TTY::Prompt.new
    input = prompt.select("Choose an option.") do |menu|
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
      menu.choice "Exit.".red, "3"
    end
    case input
    when "1"
      find_concert
    when "2"
      list_concerts
    when "3"
      exit(0)
    else
      puts "Invalid input, please try again.".red
      puts ""
      show_options
    end
  end

  def input_date(num)
    concert_date = ""
    loop do
      concert_date = gets.chomp
      if num == 2 && concert_date == ""
        puts "Cannot leave the end of the date range blank."
      elsif concert_date == ""
        break
      else
        begin
          Date.strptime(concert_date, "%m/%d/%y")
        rescue ArgumentError
          puts "Invalid date. Enter a date in the format (mm/dd/yy) \n".red
        else
          break
        end
      end
    end
    concert_date
  end

  def print_and_select_found_concerts(concert_list)
    puts ""
    prompt = TTY::Prompt.new
    input = prompt.select("Choose a concert to add to your list.", per_page: 1) do |menu|
      concert_list.each_with_index do |concert, i|
        menu.choice "Entry #{i + 1}/#{concert_list.length}\n#{concert.to_string}", i
      end
      menu.choice "Nope, don't like any of these. Take me back to the main menu.", -1
    end
    if input < 0
      show_options
    end
    pick_concert_to_add(input, concert_list)
  end

  def pick_concert_to_add(input_num, concert_list)
    poss_dups = UserConcert.where(user_id: @current_user.id, concert_id: concert_list[input_num].id)
    if poss_dups.size > 0
      puts "That concert is already in your list. Taking you back to the selection screen.".red
      find_concert
    else
      UserConcert.create(user_id: @current_user.id, concert_id: concert_list[input_num].id)
      choose_to_view_list
    end
  end

  def choose_to_view_list
    prompt = TTY::Prompt.new
    input = prompt.select("Would you like to view your list of concert or make another selection?") do |menu|
      menu.choice "Make another selection.", "1"
      menu.choice "View list.", "2"
      menu.choice "Exit.".red, "3"
    end
    puts ""
    case input
    when "1"
      find_concert
    when "2"
      list_concerts
    when "3"
      exit(0)
    else
      puts "Invalid input.".red
      choose_to_view_list
    end
  end

  def find_concert
    puts "Enter the start date (mm/dd/yy) of the date range for your concerts (or leave blank to search for concerts on all dates)."
    puts ""
    begin_concert_date = input_date(1)
    end_concert_date = ""
    if begin_concert_date != ""
      puts "Enter the end date (mm/dd/yy) of the date range for your concerts."
      puts ""
      end_concert_date = input_date(2)
    end
    puts "Enter a city for your concerts (or leave blank to search for concerts in all cities)."
    puts ""
    concert_city = gets.chomp
    puts "Enter an artist for your concerts (or leave blank to search for concerts by all artists)."
    puts ""
    concert_artist = gets.chomp
    concert_list = Concert.our_select(date1: begin_concert_date, date2: end_concert_date, city: concert_city, artist: concert_artist)
    if concert_list.empty?
      empty_return
      return
    end

    concert_list = concert_list.sort_by do |concert|
      [concert.date, concert.artist.name]
    end

    puts "\nHere are your concerts:\n"
    print_and_select_found_concerts(concert_list)
  end

  def decision_to_add(concert_list)
    prompt = TTY::Prompt.new
    yes_or_no = prompt.select("Would you like to add one of these concerts to your list?") do |menu|
      menu.choice "Yes.", "1"
      menu.choice "No.".red, "2"
    end
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
    @current_user = User.find(@current_user.id)
    my_concerts = @current_user.concerts.sort_by do |concert|
      [concert.date, concert.artist.name]
    end
    puts ""
    if my_concerts.empty?
      puts "You have no concerts saved; please add some concerts to your list and try again.".red
      show_options
    else
      puts ""
      my_concerts.each do |concert|
        puts concert.to_string
        puts ""
      end
      prompt = TTY::Prompt.new
      input = prompt.select("Would you like to remove a concert from your list?") do |menu|
        menu.choice "Remove a concert.", "1"
        menu.choice "Return to main menu.", "2"
      end
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
    prompt = TTY::Prompt.new
    input = prompt.select("Your search did not match any concerts in the database. Try again?") do |menu|
      menu.choice "Restart search.", "1"
      menu.choice "Return to main menu.", "2"
    end
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
    puts ""
    @current_user = User.find(@current_user.id)
    my_concerts = @current_user.concerts.sort_by do |concert|
      [concert.date, concert.artist.name]
    end
    prompt = TTY::Prompt.new
    delete_num = prompt.select("Choose a concert to delete from your list.", per_page: 1) do |menu|
      my_concerts.each_with_index do |concert, i|
        menu.choice "Entry #{i + 1}/#{my_concerts.length}\n#{concert.to_string}", i
      end
    end
    to_delete = UserConcert.find_by(user_id: @current_user.id, concert_id: my_concerts[delete_num].id)
    to_delete.destroy
    @current_user = User.find(@current_user.id)
    puts "Here is your updated concert list:"
    list_concerts
  end
end
