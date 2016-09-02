class EmailList < ActiveRecord::Base
  belongs_to :user
  belongs_to :email_kind
end
