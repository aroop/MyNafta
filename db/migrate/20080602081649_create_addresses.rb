class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :address_type
      t.string :name
      t.string :contact
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :address_4
      t.string :city
      t.string :county
      t.string :state
      t.string :country
      t.string :tax_id
      t.string :status
      t.string :dunsnumber
      t.string :phone_no
      t.string :email
      t.string :fax
      t.string :postal_code
      t.timestamps
    end
    Address.reset_column_information
    
    (3..(3 + rand(10))).each do |i|
      address = Address.new
      address.name = "Du pont #{i}"
      address.address_1 = "Address 1 for #{i}"
      address.address_2 = "Address 2 for #{i}"
      address.address_3 = "Address 3 for #{i}"
      address.address_4 = "Address 4 for #{i}"
      address.tax_id = "TAX ID #{i}"
      address.address_type = "Supplier"
      address.save!
    end

    (2..(2 + rand(10))).each do |i|
      address = Address.new
      address.name = "Samsung #{i}"
      address.address_1 = "Address 1 for #{i}"
      address.address_2 = "Address 2 for #{i}"
      address.address_3 = "Address 3 for #{i}"
      address.address_4 = "Address 4 for #{i}"
      address.address_type = "Importer"
      address.tax_id = "TAX ID #{i}"
      address.save!
    end
  end

  def self.down
    drop_table :addresses
  end
end