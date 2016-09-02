class AddHouseholdJob < ActiveJob::Base

  def self.perform(current_user_id, contact_array, status)
    if status == "pending_join" or status == "approved"
      @contacts = contact_array

      @contacts.each do | contact|
        if contact.is_member_of_household?
          @household = contact.household

        else
          @household = Household.new
        end
      end
    
      default_address_id = @household.find_new_default_address_id(contact_array)
      @household.update_attributes(name: @household.default_name(contact_array),
                                    default_address_id: default_address_id, 
                                    editor_user_id: current_user_id,
                                    importer_user_id: current_user_id,
                                    status: status
                                  )

      @household.save
      @contacts.each do |contact|
        ContactHousehold.create!(status: status, contact_id: contact.id, household_id: @household.id)

      end

    end
  end


end
