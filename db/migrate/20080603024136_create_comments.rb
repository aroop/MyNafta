class CreateComments < ActiveRecord::Migration
	def self.up
  	create_table :comments, :force => true do |t|
    	t.column :title, :string, :default => ""
	    t.column :comment, :string, :default => ""
  	  t.column :created_at, :datetime, :null => false
    	t.column :commentable_id, :integer, :default => 0, :null => false
    	t.column :commentable_type, :string, :default => "", :null => false
    	t.column :user_id, :integer, :default => 0, :null => false
  	end
  	add_index :comments, ["user_id"], :name => "fk_comments_user"
	end

	def self.down
  	drop_table :comments
	end
end