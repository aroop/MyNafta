class Address < ActiveRecord::Base
	
	named_scope :suppliers, :conditions => {:address_type => 'Supplier'}
	named_scope :importers, :conditions => {:address_type => 'Importer'}
	
	has_many :part_details
	
	has_many :user_assignments
	has_many :users, :through => :user_assignments
	
	def full_address
	 "#{address_1} #{address_2} #{address_3} #{address_4}"
	end
	
	def id_with_name
	 "#{name} - #{id}"
	end
	
end