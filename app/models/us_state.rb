class USState < ActiveRecord::Base
  has_many :addresses

  has_many :primary_addresses, class_name: "Address", foreign_key: 'us_state_id'

end
