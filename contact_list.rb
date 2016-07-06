require_relative 'contact'

class ContactList
  def self.main_menu
    puts "Here is a list of available commands:
    new - Create a new contact
    list - List all contacts 
    show - Show a contact 
    search - Search a contact
    help - Show main menu"
  end
  
  def self.user_input
    commands = ARGV[0]
    case commands
      when "list"
        puts Contact.all
      when "show"
        input_id = ARGV[1]
        puts Contact.find(input_id)
      when "search"
        input_term = ARGV[1]
        puts Contact.search(input_term)
      when "new"
        puts "Please enter the name for your new contact: "
        name_input = STDIN.gets.chomp
        puts "Please enter the email for your new contact: "
        email_input = STDIN.gets.chomp
         contact = Contact.new( {'name': name_input, 'email': email_input })
         contact.save 
         contact.to_s
         puts "Your contact was successfully created."
      when "update"
        puts "Please enter the id of the contact that you want to update: "
        id_input = ARGV[1]
        contact = Contact.find(id_input)
        if contact
          puts "Contact found"
          puts "Set new name:"
          contact.name = STDIN.gets.chomp
          puts "Set new email:"
          contact.email = STDIN.gets.chomp
          contact.save
          puts "Your contact has been updated."
        else
          puts "Contact does not exists"
        end
      when "destroy"
          id_input = ARGV[1]
          delete_contact = Contact.find(id_input)
          if delete_contact
            delete_contact.destroy
          else 
            puts "Contact does not exist"
          end
      else
        puts ContactList.main_menu
      end
  end
end

ContactList.user_input

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.


  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

