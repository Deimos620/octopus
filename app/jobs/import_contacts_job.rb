class ImportContactsJob < ActiveJob::Base

  def self.perform(file, set_list_id, current_user_id, import_source, auto_add_to_list, file_type)

    Contact.destroy_all
    Address.destroy_all
    Guest.destroy_all
    if import_source == "custom"
 
      CSV.foreach(file.path, headers: true)do |row|
        import_hash = row.to_hash
        contact_hash = ImporterTool.find_contact_hash_from(current_user_id, import_source, import_hash)
        #create/update contact address
        contact = Contact.where(first_name: import_hash["first_name"], last_name: import_hash["last_name"], email: import_hash["email"]).first
        if contact.present?
          contact.update_attributes(contact_hash)
          contact.save
          # Flag.create(category: 'contact_changed', owner_id: contact.id, owner_type: "Contact")
        else
          # contact = Contact.create(editor_user_id: current_user_id, user_id: current_user_id, first_name: import_hash["first_name"], last_name: import_hash["last_name"] )
          contact = Contact.create!(contact_hash)
          # contact.save!
        end 
        home_address_hash = ImporterTool.find_address_hash_from(current_user_id, import_source, import_hash, "home")
        home_address = Address.create!(home_address_hash)
        home_address.owner_type = "Contact"
        home_address.owner_id = contact.id
        home_address.save!
        if auto_add_to_list == "true"
          AddContactToGuestListJob.perform(contact, set_list_id)
        end
      end  
    elsif import_source == "google"

       CSV.foreach(file.path, headers: true)do |row|
        import_hash = row.to_hash
        contact_hash = ImporterTool.find_contact_hash_from(current_user_id, import_source, import_hash)
        puts "#{contact_hash}"
        #create/update contact address
        contact = Contact.where(first_name: import_hash["first_name"], last_name: import_hash["last_name"], email: import_hash["email"]).first
        if contact.present?
          contact.update_attributes(contact_hash)
          contact.save
          # Flag.create(category: 'contact_changed', owner_id: contact.id, owner_type: "Contact")
        else
          # contact = Contact.create(editor_user_id: current_user_id, user_id: current_user_id, first_name: import_hash["first_name"], last_name: import_hash["last_name"] )
          contact = Contact.create!(contact_hash)
          # contact.save!
        end
        # ImporterTool.find_address_hash_from(current_user_id, import_source, import_hash, "home")
        ImporterTool.add_google_addresses(current_user_id, import_hash, contact)

        # if import_hash["Home Address"].present?
        #   home_address_hash = ImporterTool.find_address_hash_from(current_user_id, import_source, import_hash, "home")
        #   home_address = Address.create!(home_address_hash)
        #   home_address.owner_type = "Contact"
        #   home_address.owner_id = contact.id
        #   home_address.save!
        # end
        # if import_hash["Work Address"].present? 
        #   work_address_hash = ImporterTool.find_address_hash_from(current_user_id, import_source, import_hash, "work")
        #   work_address_hash = Address.create!(work_address_hash)
        #   work_address_hash.owner_type = "Contact"
        #   work_address_hash.owner_id = contact.id
        #   work_address_hash.save!
        # end

        if auto_add_to_list == "true"
          AddContactToGuestListJob.perform(contact, set_list_id)
        end
      end
    elsif import_source == "outlook"
    elsif import_source == "apple"
    else
    end       
        
  end

  


end
