class CreateConfigValues < ActiveRecord::Migration
  def self.up
    create_table :config_values do |t|
      t.string :system
      t.string :code
      t.string :value
      t.text :description_1
      t.text :description_2
      t.timestamps
    end
    ConfigValue.reset_column_information
    ['A', 'B', 'C', 'D1', 'D2', 'E', 'F'].each do |value|
      cv = ConfigValue.new
      cv.system = "NAFTA"
      cv.code = "PC"
      cv.value = value
      cv.save!
    end
    
    ['US', 'CA', 'MX'].each do |value|
      cv = ConfigValue.new
      cv.system = "NAFTA"
      cv.code = "CO"
      cv.value = value
      cv.save!
    end
    
    ['CN', 'NC', 'NO'].each do |value|
      cv = ConfigValue.new
      cv.system = "NAFTA"
      cv.code = "NEC"
      cv.value = value
      cv.save!
    end
    
    ['NO1', 'NO2', 'NO3', 'YES'].each do |value|
      cv = ConfigValue.new
      cv.system = "NAFTA"
      cv.code = "PG"
      cv.value = value
      cv.save!
    end
    #Preference Criteria: PC
    #Producer: PG
    #Net Cost: NEC
    #Nafta COO: CO
  end

  def self.down
    drop_table :config_values
  end

end