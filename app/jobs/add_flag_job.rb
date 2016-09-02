class AddFlagJob < ActiveJob::Base

  def self.perform(owner_type, owner_id, category, note)
    Flag.create!(owner_type: owner_type, owner_id: owner_id, category: category,
                 note: note)
  end

  


end
