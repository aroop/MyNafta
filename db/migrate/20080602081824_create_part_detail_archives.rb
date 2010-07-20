class CreatePartDetailArchives < ActiveRecord::Migration
  def self.up
    create_table :part_detail_archives do |t|
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
  end

  def self.down
    drop_table :part_detail_archives
  end
end