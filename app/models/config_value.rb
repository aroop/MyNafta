class ConfigValue < ActiveRecord::Base
  named_scope :preference_criterias, :conditions => {:code => 'PC'}
  named_scope :producers, :conditions => {:code => 'PG'}
  named_scope :net_costs, :conditions => {:code => 'NEC'}
  named_scope :coos, :conditions => {:code => 'CO'}
end