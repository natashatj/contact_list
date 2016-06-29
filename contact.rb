require 'csv'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email
  attr_reader :id
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(id, name, email)#make consistent
    @id = id
    @name = name
    @email = email 
    
    # TODO: Assign parameter values to instance variables.
  end

  def to_s
    "#{id}: #{name} (#{email})"
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      contacts = Array.new
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
       CSV.foreach('contacts.csv') do |row|
        contacts << Contact.new(row[0], row[1], row[2])
      end
      contacts
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      new_id = all.length + 1
      new_contact = [new_id, name, email]
      CSV.open('contacts.csv', 'a') do |csv|
        csv << new_contact
      end
      new_contact = Contact.new(new_id, name, email)
      #figure out what is the something plus one for id
      #count 
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      all.each do |contact|
        if contact.id == id
          return contact
        end
      end
      nil
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      #go through csv
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      all.each do |contact|
        if contact.name.include?(term) || contact.email.include?(term)
          return contact.to_s
        end
      end
    end
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
  end
end
# contact = Contact.new("Natasha", "natasga@gmail.com")
# puts " id = #{contact.id}name = #{contact.name}, email = #{contact.email} "
# puts Contact.all.inspect

#TODO method to create a new object
