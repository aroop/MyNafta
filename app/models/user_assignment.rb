class UserAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  acts_as_list :scope => :user
end