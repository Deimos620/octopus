class Household < ActiveRecord::Base
  has_many :addresses, class_name: "Address", foreign_type: "Household", foreign_key: 'owner_id', dependent: :destroy
  has_many :contact_households, dependent: :destroy
  has_many :contacts, through: :contact_households

  enum status: [:unknown ,  :pending_join, :pending_split, :rejected, :approved, :finalized]
  scope :pending_join, -> { where(status: 1) }
  scope :pending_split, -> { where(status: 2) }
  scope :approved, -> { where(status: 4) }




     #rework this
    def default_address
      #use complete address
      if self.addresses.present?
        self.addresses.first
      # if self.default_address_id.present?
      #   Address.find(self.default_address_id)
      # elsif   self.contacts.first.default_address.present?
      #       self.contacts.first.default_address
      # else
      #       self.addresses.first
      end
    end



    #rework this
  

    def default_name(contact_array, *)
      formality = formality || 22
      first_contact = contact_array.first
      if contact_array.count == 2
        contact_couple_name(formality,  contact_array) 
      elsif contact_array.count >> 2
        contact_family_name(formality,  contact_array) 
         "The #{first_contact.last_name} Family" 
      elsif contact_array.count == 1
        contact_single_name(formality,  contact_array.first) 
       " #{first_contact.name}" 
      end
    end

    def contact_couple_name(formality,  contact_array)
      first_contact = contact_array.first
      second_contact = contact_array.first
      if formality == 1
        if first_contact.shares_last_name?(second_contact)

        else

        end
      elsif formality ==2
        if first_contact.shares_last_name?(second_contact)

        else

        end
      elsif formality == 3
        "#{first_contact.name_with_prefix} & #{second_contact.name_with_prefix}" 

      else
        " #{first_contact.name} & #{second_contact.name}" 
      end
    end

    def contact_family_name(formality, contact_array)
      if formality == 1
        "The Griswold Family"
      else
        "The Griswolds"
      end
    end

    def contact_single_name(formality, contact)
      contact.name_with_prefix
    end

    def find_new_default_address_id(contact_array)
      @contacts = contact_array
      if default_address.present?
        default_address.id
      elsif  @contacts.first.default_address.present?
        new_address_hash = @contacts.first.default_address.attributes
        new_address = Address.new(new_address_hash)
        new_address.save
        new_address.id
      elsif @contacts.second.default_address.present?
         @contacts.second.default_address.id
      else
         nil
      end
    end

    def is_approved?
      self.status == "approved"
    end

    def is_rejected?
      self.status == "rejected"
    end

    after_update :finalize_household_status

    def finalize_household_status
      puts "#{self.name} #{self.status}" * 1000
      CompleteHouseholdsJob.perform(self)

      # if  is_approved?
      #   puts "#{self.name} #{self.status}" * 1000
      #   CompleteHouseholdsJob.perform(self)
      # elsif is_rejected?
      #   puts "#{self.name} #{self.status}" * 1000

      #   CompleteHouseholdsJob.perform(self)

      # end
    end

end
