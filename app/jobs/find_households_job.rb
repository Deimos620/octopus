class FindHouseholdsJob < ActiveJob::Base

  # user = User.second
  # FindHouseholdsJob.perform(user)

  def self.perform(current_user)
    #checking for splitable contacts
    @contacts = current_user.imported_contacts

    @splitable_contacts = @contacts.where("first_name LIKE ?", "%&%") + @contacts.where("first_name LIKE ?", "% and %") 
    @splitable_contacts.each do |splitable_contact|
     
      SplitHouseholdsJob.perform(current_user.id, splitable_contact)
       puts "#{splitable_contact.name}  MAYBE TWO CONTACTS"
    end 

          puts "*** JOININ FININISHED ***" * 10

    #----checking for joinable contacts
    @contacts = current_user.imported_contacts
#     @contacts.each do |contact|
#       other_contacts = Contact.where.not(id: contact.id)

#       other_contacts.each do |other_contact|
#         puts "checking #{contact.name} and #{other_contact.name}"
#         if  contact.maybe_household_with?(other_contact) 

#            possible_household = [other_contact,  contact]
#           AddHouseholdJob.perform(current_user.id, possible_household, "pending_join")
#           puts "#{contact.name}  MAYBE household with #{other_contact.name}"

# #           AddFlagJob.perform("Contact", contact.id, "Potential Household
# # ", "Are these two in the same household?", "Contact", other_contact.id )
#         else
#           puts "#{contact.name} not in household with #{other_contact.name}"
#         end
#       end
#     end 

  end

  

end
