class ParticipantRole < ActiveRecord::Base
    include BasicScopes


  def self.types
    [
      HelperParticipantRole.types, RecipientParticipantRole.types,  OrganizerParticipantRole.types, VendorParticipantRole, OrganizerParticipantRole
      
    ].flatten
  end

  belongs_to :participant
  belongs_to :project

  # belongs_to :user, through: :participant
  belongs_to :grantor, class_name: "Participant",  foreign_key: "grantor_participant_id"
  #has_many :participants

  # belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"
  enum status: [:unknown , :unseen, :pending, :accepted, :maybe, :declined]

  scope :firm_answers, -> { where("status = ? or status = ?", 3, 5)}

  

  # --- VALIDATIONS ---
  #STI Requires Type
  validates :type, presence: true, allow_blank: false


  # default_scope -> { includes(:project)}

  def kind
    '???'
  end


  def code
    "?"
  end

  def see_budget
    false
  end

  def invite_guests
    false
  end

  def is_recipient
    false
  end

  def is_wedding_related
   false
  end

  def can_participate
    true
  end

  def see_guests
    false
  end

  def icon_name
    'default'
  end

  # def is_organizer?
  #   false
  # end

 
 def first_name
    self.participant.user.first_name
 end

  def name
    self.participant.name
 end

  def is_recipient?
    false
  end

  def is_helper?
    false
  end

  def can_organize?
    false
  end

  def is_committee_head?
    false
  end

  def level
    10000
  end

  #Privileges
  def privleges_list
    "typically the...."
  end

  def see_the_budget
    false
  end

  def see_the_guest_list
    true
  end
  
  def add_guests
    true
  end

  def create_seating_chart
    false
  end

  def create_milestones
    false
  end

  def create_tasks
    false
  end

  def assign_milestones
    false
  end

  def assign_tasks
    false
  end

  def add_helper_participants
    true
  end

  def add_viewer_participants
    true
  end

  def add_organizer_participants
    false
  end

  def add_recipient_participants
    true
  end

  def add_commitee_participants
    false
  end

  def add_vendor_participants
    false
  end

  def add_viewer_participants
    false
  end


  def current_as_of?(date)
    if end_date && end_date < date
      false
    else
      true
    end
  end

  def ended_as_of?(date)
    !current_as_of?(date)
  end

  def current?
    current_as_of?(Date.today)
  end

  def ended?
    !current?
  end

  def has_active_flags?
    flags.any?{|f|f.active?}
  end



  

  after_update :set_participation
  after_update :rsvp_additional_roles

  private

  def set_participation
    # participant = Participant.find(self.participant_id)
    # if self.status == "accepted"
    #   participant.status = self.status
    #   participant.save
    # end
    # if self.status != "accepted" && participant.participant_roles.count >>1
    #   elsif self.status != "accepted" && participant.participant_roles.count == 1
    #   participant.status = self.status
    #   participant.save
    # end
  end


  def rsvp_additional_roles
    # if self.participant_roles.count << 1
    #   if self.status != self.participant.status
    #     #send rsvp
    #   end
    # end
  end
  
  # private
end
