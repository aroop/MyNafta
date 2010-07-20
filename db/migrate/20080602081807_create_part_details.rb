class CreatePartDetails < ActiveRecord::Migration
  def self.up
    create_table :part_details do |t|
      t.string :status
      t.string :item_number
      t.string :supplier_item
      t.string :item_description
      t.string :hs_tariff_code
      t.string :pref_criteria
      t.string :producer
      t.string :net_cost
      t.string :nafta_coo
      t.boolean :item_type
      t.integer :plant_id
      t.text :electronic_id
      t.string :product_style
      t.boolean :certified
      t.string :certificate_no
      t.integer :address_id
      t.timestamps
    end

    PartDetail.reset_column_information
    (5..(5 + rand(100))).each do |i| 
      part = PartDetail.new
      part.supplier_item = "supplier_item#{i}"
      part.item_number = "item_number#{i}"
      part.item_description = "Description for the item #{i} goes here"
      part.address = Address.find(1 + rand(Address.find(:all).size))
      part.save!
    end
  end

  def self.down
    drop_table :part_details
  end

end