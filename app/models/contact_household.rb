class ContactHousehold < ActiveRecord::Base
  belongs_to :contact
  belongs_to :household
end
