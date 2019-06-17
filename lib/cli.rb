class CommandLineInterface
  def greet
    "Hello, welcome to your friendly concert viewer"
  end

  def show_options
    puts "1. Find or create a venue."
    puts "2. Find or create an artist."
    puts "3. Find or create a concert."
  end

  def venue_selected
    puts "Enter the name of a venue that you would like to find or create."
  end
end
