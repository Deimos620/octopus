class ListRecipient < ActiveRecord::Base
  belongs_to :guest
  belongs_to :household
  belongs_to :list




end
