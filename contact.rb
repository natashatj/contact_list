require 'csv'
require 'pg'
require 'pry'
require './db_connect'

class Contact

  attr_accessor :name, :email
  attr_reader :id

  DBConnect::connection()

  
  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @email = params[:email]
  end

  def to_s
    "#{id}: #{name} (#{email})"
  end

  def to_a
    [@id, @name, @email]
  end

  def is_saved? 
    @id != nil
  end

  def save
    if is_saved?
      res = DBConnect::connection.exec_params('UPDATE contacts SET name=$1, email=$2 WHERE id=$3::int;',[@name, @email, @id])
    else
      res = DBConnect::connection.exec_params('INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id, name, email;',[@name, @email])

      @id = res[0]['id']
      return res[0]
    end
  end

  class << self

    def all
      contact_results = []
      rows = DBConnect::connection.exec('SELECT * FROM contacts;') 
      rows.each do |row|
        contact_results << Contact.new(DBConnect.hmap(row))  
      end
      contact_results
    end

    def search(term)
      search_results = []
      rows = DBConnect::connection.exec_params("SELECT * FROM contacts WHERE name LIKE $1;", ["%#{term}%"]) 
      rows.each do |row|
        search_results << Contact.new(DBConnect.hmap(row))
      end
      search_results
    end

    def find(id)
      row = DBConnect::connection.exec_params("SELECT * FROM contacts WHERE id = $1::int;", [id])
      if row.count > 0
        row = row[0] 
        Contact.new(DBConnect.hmap(row))
      else
        return nil
      end
    end 

    def destroy
      DBConnect::connection.exec_params("DELETE FROM contacts WHERE id=$1::int;", [id])
    end
  end
end
