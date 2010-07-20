class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string :login
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :title
      t.string :last_name
      t.string :language
      t.string :email

      #Password
      t.string :crypted_password
      t.string :salt
      
      t.string :company
      t.string :phone
      t.string :fax
      t.integer :role_id
      
      t.timestamps
      t.datetime :last_login
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.string :activation_code
      t.datetime :activated_at
      t.string :state, :null => :no, :default => 'passive'
      t.datetime :deleted_at
      t.string :password_reset_code, :limit => 40      
    end
    
    User.reset_column_information
    user = User.new
    user.login = "admin"
    user.title = "Nafta Representive"
    user.company = "Nafta Representive Company"
    user.first_name = "Aaron"
    user.last_name = "Smith"
    user.email = "Aaron.Smith@NaftaRepresentiveCompany.com"
    user.activated_at = Time.now
    user.password = "admin"
    user.password_confirmation = "admin"
    user.role = Role.find_by_name("Admin")
    user.save!
    user.state = 'active'
    user.save!

    user = User.new
    user.login = "supplier"
    user.title = "Supplier Representive"
    user.company = "Supplier Representive Company"
    user.first_name = "Julie"
    user.last_name = "Roberts"
    user.email = "Julie.Roberts@SupplierRepresentiveCompany.com"
    user.activated_at = Time.now
    user.password = "supplier"
    user.password_confirmation = "supplier"
    user.role = Role.find_by_name("Supplier")
    user.save!
    user.state = 'active'
    user.save!

    user = User.new
    user.login = "normal"
    user.title = "Normal User"
    user.company = "Normal User Company"
    user.first_name = "Sam"
    user.last_name = "Dsouza"
    user.email = "Sam.Dsouza@NormalUserCompany.com"
    user.activated_at = Time.now
    user.password = "normal"
    user.password_confirmation = "normal"
    user.role = Role.find_by_name("normal")
    user.save!
    user.state = 'active'
    user.save!
  end

  def self.down
    drop_table "users"
  end
end