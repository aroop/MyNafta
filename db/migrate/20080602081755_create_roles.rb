class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    Role.reset_column_information
  
    # All the options will be allowed for this user
    role = Role.new
    role.name = "Admin"
    role.description = "Description of the admin user goes  here"
    role.save!
    
    # Item Maintance & certification
    role = Role.new
    role.name = "Supplier"
    role.description = "Description of the supplier user goes  here"
    role.save!

    # Only option for Archive Tab
    role = Role.new
    role.name = "Normal"
    role.description = "Description of the supplier user goes  here"
    role.save!

  end

  def self.down
    drop_table :roles
  end

end