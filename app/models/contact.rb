class Contact < ActiveRecord::Base
  # belongs_to :home_address
  # belongs_to :work_address

  belongs_to :user
  has_many :guests

  has_many :list_recipients, through: :guests
  has_many :lists, through: :list_recipients

  has_many :addresses, class_name: "Address", foreign_type: "Contact", foreign_key: 'owner_id', dependent: :destroy
  has_one :contact_household, dependent: :destroy
  has_one :household, through: :contact_household
  belongs_to :user_editor, class_name: "User",  foreign_key: "user_id"


  enum status: [:unknown ,  :pending_new, :pending_edit, :pending_discard, :rejected, :approved]
  scope :not_pending_discard, -> { where.not(status: 3) }

    # default_scope -> { where(status: 4)}
    default_scope -> { includes(:addresses)}
    default_scope -> { includes(:household)}
    default_scope -> { includes(:guests)}



# def self.import(file, set_list_id)
  
#   # header = spreadsheet.row(1)
#   # (2..spreadsheet.last_row).each do |i|
#   #   row = Hash[[header, spreadsheet.row(i)].transpose]
#   CSV.foreach(file.path, headers: true) do |row|
#       contact_hash = row.to_hash
#       # row.strip.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
#       c = Contact.new(first_name: ["contact_hash"]["first_name"])
#       c.save!
#       # c.add_contact_to_guest_list(set_list_id)
#     end

# end

def is_member_of_household?
  self.household.present?
end


def self.import(file, set_list_id, current_user_id, auto_add_to_list, import_source)
  ImportContactsJob.perform(file, set_list_id, current_user_id, import_source, auto_add_to_list, self.file_type(file))#put category  
end

def add_contact_to_guest_list(list_id)
  # guest = Guest.create(contact_id: self.id)
  # guest.save!
  # ListRecipient.create!(list_id: list_id, guest_id: guest.id)
  AddContactToGuestListJob.perform(self, list_id)
end

def editor
  user_editor.name  unless user_id.blank?
end

def self.file_type(file)
  case File.extname(file.original_filename)
  when ".csv" then "CSV"
  when ".xls" then "XLS"
  when ".xlsx" then "XLSX"
  else raise "Unknown file type: #{file.original_filename}"
  end
end

def primary_household_address
  if household.present? && household.addresses.present?
    household.addresses.primary.first
  else
    self.primary_address
  end
end

def primary_address
    self.addresses.primary.first
end

  def default_address
    if self.addresses.present?
      if     self.addresses.primary.first.present? &&  self.addresses.primary.first.is_complete?
            self.addresses.primary.first
      else
            self.addresses.first if self.addresses.first.is_complete?
              
      end
    end
  end

  def default_address_id
    if    self.default_address.present? 
          self.default_address.id
    else
      nil
    end
  end

  def name
    first_name + " " + last_name rescue first_name + "" rescue "" + last_name rescue "Contact"
  end

  def name_with_middle
    "#{first_name} #{middle_name} #{last_name} "
    # first_name + " " + last_name  rescue first_name + "" rescue "" + last_name rescue "User"
  end

  def female?
    gender == "female"
  end

  def male?
    gender == "male"
  end

  def set_prefix
    if prefix 
      prefix 
    elsif gender.present?
      if female?
       "Ms."
      elsif male?
       " Mr."
      end
    end
  end

  def name_with_prefix
    set_prefix + " " + name
  end

  def name_with_prefix_and_suffix
    set_prefix + " " + name rescue set_prefix  + " " + suffix
  end

  def name_with_prefix_and_middle_and_suffix
    set_prefix + " " + name_with_middle rescue set_prefix + " " +  suffix
  end

  def is_on_list?(list)
    self.guests.present? && self.list_recipients.where(list_id: list.id).present?
  end

  def maybe_household_with?(other_contact)
    self.household.blank? && other_contact.household.blank? && 
    self.shares_last_name?(other_contact)  &&
     self.shares_city?(other_contact) 

  end



  def shares_city?(other_contact) 

    self.default_address.city == other_contact.default_address.city if self.default_address.present? && other_contact.default_address.present? 
  end

  def shares_last_name?(other_contact)
    self.last_name == other_contact.last_name if self.last_name.present? 
  end

  def shares_phone?(other_contact)
    self.home_phone == other_contact.home_phone if self.home_phone.present?   or
    self.primary_phone == other_contact.home_phone  if self.primary_phone.present? or
    self.primary_phone == other_contact.primary_phone if self.primary_phone.present?   or
    self.home_phone == other_contact.primary_phone if self.home_phone.present? 
  end

  def has_similar_address?(other_contact)
    if self.default_address.present? && other_contact.default_address.present?
      self.default_address.address_1 == other_contact.default_address.address_1 if  self.address_1.present? 
    end
  end

  def find_first_name(which_name)
    self.first_name.split(/&/) 
    names = self.first_name.split(/&/) 
    if which_name == "first"
      # this needs to be the first name in the string FirstContact & SecondContact
      names.first
    elsif which_name == "second"
       names.second
    end
  end

  


  
end
