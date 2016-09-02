class Participant < ActiveRecord::Base
  include ProjectsHelper
  include BasicScopes


  belongs_to :user
  belongs_to :project
  belongs_to :invitor, class_name: "Participant",  foreign_key: "invitor_participant_id"
  belongs_to :editor, class_name: "Participant",  foreign_key: "editor_participant_id"
  has_many :received_email_logs, class_name: "EmailLog",  foreign_key: "receiver_participant_id"
  has_one :honored_guest, dependent: :destroy
  has_many :participant_roles, dependent: :destroy
  has_many :participant_titles, dependent: :destroy

  has_many :projects_organized, class_name: "Project",  foreign_key: "organizer_participant_id"
  has_many :events, dependent: :destroy
  has_many :events_attending, through: :attendees, source: "Event"

  validates :email, presence:  {message: "Email can't be blank"}
  validates :email, uniqueness: {case_sensitive: false, scope: :project_id} 
  has_many :attendees,  dependent: :destroy

  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :participant_roles, allow_destroy: true
  accepts_nested_attributes_for :participant_titles, allow_destroy: true
  accepts_nested_attributes_for :honored_guest

  enum status: [:unknown , :unseen, :pending, :accepted, :maybe, :declined]
  # default_scope -> { includes(:participant_roles)}

  scope :accepted, -> { where(status: 3) }
  scope :unseen, -> { where(status: 1) }
  scope :maybe, -> { where(status: 4) }
  scope :declined, -> { where(status: 5) }
  scope :pending, -> { where(status: 2) }
  scope :undecided, -> {where.not(status: 5).where.not(status: 3)}

  scope :firm_answers, -> { where("status = ? or status = ?", 3, 5)}


  def name
    if self.user.present?
      self.user.name
    elsif self.honored_guest.present?
      self.honored_guest.invited_name
    else
      self.email
    end
  end

  def first_name
    if self.user.present?
      self.user.first_name
    elsif self.honored_guest.present?
      self.honored_guest.name
    else
      self.email
    end
  end

   def limited_name
    if self.user.present?
      self.user.name
    else
      shortened = self.email.truncate(9)
      "#{shortened}@xxx.com"
    end
  end

  def name_and_email
     if self.user.present?
      "#{self.user.name}(#{self.user.email})"
    else
     self.email
    end
  end

  def has_user?
    if self.user.present?
      true
    end
  end

  def status_icon
    if self.status == "accepted"
      "fa fa-check"
    elsif self.status == "maybe" or self.status == "pending"
      "fa fa-question"
    elsif self.status == "declined"
      "fa fa-times"
    end
  end

  def can_be_reminded?
    self.unseen? && self.updated_at != Date.today && self.times_contacted << 2
  end

  def dormant_five_days?
    self.unseen? && self.updated_at >= (Time.now + 4.days ) && self.times_contacted << 3
  end


  def is_recipient?
      self.has_recipient_organizer_participant_role? or self.has_recipient_participant_role?
   
  end

  def is_helper?
    self.has_helper_participant_role?
   
  end

  def can_organize?
    self.has_recipient_organizer_participant_role? or self.has_organizer_participant_role?
  end

  def is_committee_head?
    self.has_committee_participant_role? 
  end

  def is_vendor?

  end

  #this is if an organizer wants to leave organizing.
  def can_abdicate?
    project = Project.find(self.project_id)
    participants = Participant.where(project_id: self.project_id).where.not(id: self.id)
    other_organizers = participants.any?{|f| f.can_organize? }
    if other_organizers.present?
      true
    end
  end


  def create_participant_role(participant_role)
    participant_role = ParticipantRole.create!(type: participant_role, project_id: self.project_id, 
                        participant_id: self.id, start_date: Date.today, 
                        grantor_participant_id:  self.editor_participant_id, 
                        editor_participant_id: self.editor_participant_id )
    ParticipantInviteJob.perform(participant_role)
  end



   ParticipantRole.types.each do |klass|


    # Conveniences within this method

    uname = klass.name.underscore
    unames = uname.pluralize
    my_current_participant_roles = lambda {|r|r.kind_of?(klass) && r.current?}
    my_ended_participant_roles= lambda {|r|r.kind_of?(klass) && r.ended?}
    my_participant_roles = lambda {|r|r.kind_of?(klass)}


    # Create e.g. my_participant.organizer_roles

    define_method (unames) do
      participant_roles.select &my_participant_roles
    end


    # Create e.g. my_participant.current_organizer_roles

    define_method ("current_#{unames}") do
      participant_roles.select &my_participant_roles
    end

    define_method ("ever_#{unames}") do
      participant_roles.select &my_participant_roles
    end




    # Create e.g. my_participant.has_organizer_role?
    # "has" implies current

    define_method("has_#{uname}?") do
      participant_roles.any? &my_current_participant_roles
      # TODO: make sure to make sure these roles have no flags
    end


    # Create a scope to find contacts who currently have this role
    # So now we can do Contact.with_turbulence_special_skill
    # TODO: Allow for expirations and only include current ratings

    scope scope_name = "with_#{uname}".to_sym, -> do
      includes(:participant_roles).where(participant_roles: {type: klass.types.map(&:name)})
    end

  end

  after_save :add_user_to_participant, if: :new_record?


  def add_user_to_participant
   user = User.find_by_email(self.email)
    if @user.present?
      self.update_attributes!(user_id: user.id)
    end
  end

  

  # after_create :send_invitation
  after_update :set_original_role 

  def set_original_role
    if self.is_first_participant_role?
      self.participant_roles.first.update_attributes!(status: self.status)
    end
  end

  def is_first_participant_role?
     self.participant_roles.count == 1
  end

  def contact_limit_reached(email_kind)
    false
  end


  #relationship
  #mother of ///
  #friend of name or name or both
  #father of
  #stepfather of
  #realtion_user_id or #both (parents, couple)
  #star == couple, parent, recipient....

  #title Mother of the Bride, Officiant, participant has many participant_titles
  #Baby's Mother/ Baby's Grandmother
  #Bride
  #Groom

end
