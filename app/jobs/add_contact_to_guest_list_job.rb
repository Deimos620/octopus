class AddContactToGuestListJob < ActiveJob::Base

  def self.perform(contact, set_list_id)
    
    guest = Guest.create(contact_id: contact.id)
    guest.save!
    list_recipient = ListRecipient.create!(list_id: set_list_id, guest_id: guest.id)
    puts "added #{guest.name} to #{list_recipient.list.name}"

  end


end
