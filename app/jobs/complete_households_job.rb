class CompleteHouseholdsJob < ActiveJob::Base

  # user = User.second
  # FindHouseholdsJob.perform(user)

  def self.perform(household)
    puts "updating #{household.name} is #{household.status}"
    puts 'EDO ' * 1000
    if household.is_approved?

      household.status = "finalized"
      household.contacts.pending_discard.each do |c|
        c.destroy
        c.contact_household.destroy
        
      end
      household.contacts.pending_new.each do |c|
        c.status = "approved"
        c.save
      end

      household.contacts.pending_edit.each do |c|
        c.status = "approved"
        c.save
      end
      household.save
      puts "updating #{household.name} is #{household.status}"

    elsif household.is_rejected?
          puts 'PEPPER ' * 1000


      household.contacts.pending_discard.each do |c|
        c.status = "approved"
      end
      household.contacts.pending_new.each do |c|
        c.contact_household.destroy
        c.destroy
      end
      household.contacts.pending_edit.each do |c|
        c.contact_household.destroy
        c.destroy
      end
      puts "updating #{household.name} is about to be DESTROYED"
      household.contact_households.destroy_all
      household.destroy



    end
      # current_user = User.find(household.editor_user_id)
      # AddHouseholdJob.perform(current_user.id, current_user.imported_contacts, 'approved')


  end

  

end
