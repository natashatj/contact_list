require_relative 'contact'

class ContactList
  def self.main_menu
    puts "Here is a list of available commands:
    new - Create a new contact
    list - List all contacts 
    show - Show a contact 
    search - Search a contact"
  end
  
 
   def self.user_input
    case ARGV[0]
      when "list"
        puts Contact.all
      when "show"
        puts Contact.find(ARGV[1])
      when "search"
        puts "Please enter search term to find desired contact: "
        puts Contact.search(ARGV[1])
      when "new"
        puts "Please enter the name for your new contact: "
        name_input = STDIN.gets.chomp
        puts "Please enter the email for your new contact: "
        email_input = STDIN.gets.chomp
         Contact.create(name_input, email_input)
         puts "Your contact was successfully created."
      when "help"
        puts ContactList.main_menu
    end
  end
end

ContactList.user_input

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.


  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

