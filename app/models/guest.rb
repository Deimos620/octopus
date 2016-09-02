class Guest < ActiveRecord::Base
  belongs_to :contact
  has_many :list_recipients

  def name
    self.contact.name
  end
end
