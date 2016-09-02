class User < ActiveRecord::Base
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # TEMP_EMAIL_PREFIX = 'change@me'
  # TEMP_EMAIL_REGEX = /\Achange@me/
  devise :database_authenticatable, :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
      :omniauth_providers => [:facebook, :google_oauth2]
  mount_uploader :avatar, AvatarUploader



  def self.from_omniauth(auth)
    if auth.provider == "google_oauth2"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.confirmed_at = Time.now
        user.accept_terms = true
        user.avatar = auth.extra.raw_info.picture
        user.birth_date = auth.extra.raw_info.birthday
        user.gender = auth.extra.raw_info.gender
        user.locale = auth.extra.raw_info.locale
        user.level = "tester"

        # user.password = Devise.friendly_token[0,20]
         user.save!
        user
      end

      
    elsif auth.provider == "facebook"
      puts 'Exo '* 1000
      puts auth
       where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name =auth.info.last_name
    
        user.confirmed_at = Time.now

      
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.accept_terms = true
        # user.avatar = auth.info.image
        # user.birth_date = auth.extra.raw_info.birthday
        user.gender = auth.info.gender
        user.locale = auth.info.locale
        user.location = auth.info.location
        user.level = "tester"

        user.password = Devise.friendly_token[0,20]
        user.save!
        user
      end
    end
  end





  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end




  def password_required?
    super && provider.blank?
  end


  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  before_save { self.email = email.downcase }
  before_save { self.first_name = first_name.capitalize }
  before_save { self.last_name = last_name.capitalize }

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z09.-]+\.[a-z]{2,4}\Z/i
  
  #validations
  validates :first_name, presence: {message: "Please enter a first name."}
  validates :last_name, presence: {message: "Please enter a last name."}
  validates :email, presence: {message: "Please enter an email."}
  validates_format_of :email, :with => EMAIL_REGEX, :message => "This is not an email"
  validates :password, presence: true, :confirmation => true, length: {minimum: 6}, :if => :password
  validates :accept_terms, :acceptance => {:accept => true,  :message => "Please accept the terms of service"}
  validates :email,
    uniqueness: {case_sensitive: false,   message: "Looks like you're already registered! Login now or click on the forgotten password link to recover your account."}, 
    if: 'email.present?'
  #enums
    GENDERS = [:unspecified, :female, :male, :other]
  enum gender: GENDERS

  #relationships
  has_one :profile, autosave: true
  has_many :participants

  has_many :projects_organized, through: :participants
  has_many :participant_roles, through: :participants
  has_many :feedbacks_edited, class_name: 'Feedback', foreign_key: 'editor_user_id'
  has_many :imported_contacts, class_name: 'Contact', foreign_key: 'importer_user_id'
  has_many :imported_households, class_name: 'Household', foreign_key: 'importer_user_id'

  has_many :imported_addresses, class_name: 'Address', foreign_key: 'importer_user_id'

  has_many :feedbacks
  has_many :projects, through: :participants
  has_many :invitees, class_name: 'Participant', foreign_key: 'invitor_user_id'
  has_many :addresses, class_name: "Address", foreign_type: "User", foreign_key: 'owner_id', dependent: :destroy
  has_many :events,  through: :participants
  has_many :attendees,  through: :events
  has_many :roles,  dependent: :destroy
  has_many :blog_authors
  has_many :blogs_authored, through: :blog_authors
  has_many :blogs_copyedited, class_name: 'BlogPost', foreign_key: 'blog_editor_user_id'
  has_many :blogs_edited, class_name: 'BlogPost', foreign_key: 'editor_user_id'
  belongs_to :sent_email_log, class_name: "EmailLog",  foreign_key: "sender_participant_id"
  has_many :social_account_authorizations, dependent: :destroy
  has_many :social_shares
  has_many :social_accounts, through: :social_account_authorizationss
  has_many :managed_social_shares, through: :social_account_authorizations, source: 'social_shares'
  has_many :email_lists, dependent: :destroy
  has_many :lists,  through: :projects_organized
  has_many :contacts, dependent: :destroy

  # has_many :profile_socials, through: :profiles
  # has_many :profiles_edited,  class_name: "Profile",  foreign_key: "editor_user_id"
  # has_many :users_edited,  class_name: "User",  foreign_key: "editor_user_id"
  # has_many :roles, dependent: :destroy
  # has_many :roles_edited,  class_name: "Role",  foreign_key: "editor_user_id"



  #nested

  accepts_nested_attributes_for :addresses

  # accepts_nested_attributes_for :project

  #scopes
  # default_scope -> { includes(:profile)}

  # before_save :set_editor_user_id


  Project.types.each do |klass|
    # Conveniences within this method
    
    uname = klass.name.underscore
    unames = uname.pluralize
    my_current_projects = lambda {|r|r.kind_of?(klass) && r.current?}
    my_ended_projects = lambda {|r|r.kind_of?(klass) && r.ended?}
    my_projects = lambda {|r|r.kind_of?(klass)}


    # Create e.g. user.current_projects

    define_method (unames) do
      projects.select &my_projects
    end

    define_method("ever_#{unames}?") do
      projects.any? &my_projects
    end

    define_method("past_#{uname}?") do
      projects.any? &my_ended_projects
    end

   define_method ("newest_#{uname}") do
    projects.select(&my_projects).sort_by(&:created_at).last
   end
    # Create e.g. my_contact.current_launch_skills

    define_method("ever_#{uname}?") do
      projects.any? &my_projects
    end

    # define_method ("current_#{unames}") do
    #   projects.select &my_current_projects
    # end

    define_method ("current_#{uname}") do
      projects.find &my_current_projects
    end

    define_method (uname.pluralize) do
      projects.select &my_projects
    end

  end

  def set_avatar
    if self.avatar.present?
      self.avatar
    else
      "default_images/default_avatar.jpg"
    end
  end

 

  def active_projects
    self.participants.accepted
  end

  def all_projects
    self.participants
  end

  def archived_projects
    self.projects.archived
  end



  # def user_project_participation(project_id)
  #   self.participants.where(project_id: project_id).first
  # end


  def current_project_participant(project_id)
    # if self.has_accepted?(project_id)
      Participant.where(project_id: project_id, user_id: self.id).first
    # end
  end


  def is_invited(project_id)
    # project = Project.find(project_id)
    participation = current_project_participant(project_id)
    if participation.present?
      true
    end
  end

  def is_organizer(project_id)
    project = Project.find(project_id)
    if self.is_invited(project_id)
      participation = current_project_participant(project_id)
      participant_roles = project.participant_roles.where(participant_id: participation.id)
      if participant_roles.present? 
        # participant_roles.any?{|p| }
       participant_roles.any?{|r| r.kind_of?(OrganizerParticipantRole)}

      end
    end
  end

  def is_recipient(project_id)
    project = Project.find(project_id)
    if self.is_invited(project_id)
      participation = current_project_participant(project.id)
      participant_roles = project.participant_roles.where(participant_id: participation.id)
      if participant_roles.present? 
       participant_roles.any?{|r| r.kind_of?(RecipientParticipantRole)}

      end
    end
  end

  def is_helper(project_id)
  end



 

  def can_edit(project_id)
    if is_recipient(project_id) or is_organizer(project_id)
      true
    end
  end

  def is_event_creator(event_id)
    event = Event.find(event_id)
    participant = Participant.find(event.participant_id)
    if participant.user_id == self.id
      true
    end
  end

  

  def has_accepted?(project_id)
    # project = Project.find(project_id)
    participation = current_project_participant(project_id)
    if participation.present?
      true
    end
  end

  def name
    first_name + " " + last_name rescue first_name + "" rescue "" + last_name rescue "User"
  end

  ###sidebar
  def invites
    orphan_invites  = Participant.where(user_id: nil).where(email: self.email) 
    if orphan_invites.present?
      orphan_invites.each do |o|
        o.user_id = self.id
        o.save
      end
    end
    self.participants
  end

  def maybe_invites
    self.invites.select{|f|f.status == 'maybe'  }
  end 

  def unseen_invites
    self.invites.select{|f|f.status == 'unseen'  }

  end 

  def pending_invites
    self.invites.select{|f|f.status == 'pending'  }

  end 
  
  def accepted_invites
    self.invites.select{|f|f.status == 'accepted'  }
  end 


  def declined_invites
    self.invites.select{|f|f.status == 'declined'  }

  end 
  

  def unanswered_invites
    self.unseen_invites + self.pending_invites
  end

  def current_projects
    
  end

  def declined_projects
    
  end

  def all_notifications
     orphan_notifications  = Notification.where(user_id: nil).where(email: self.email) 
    if orphan_notifications.present?
      orphan_notifications.each do |o|
        o.user_id = self.id
        o.save
      end
    end
      self.notifications
  end

  def global_notifications
    self.unseen_invites 
  end

  def unseen_notifications
    self.all_notifications.select{|f|f.status == 'unseen'  }
  end

  def is_queen?
    if self.roles.where(type: "QueenAdminRole").present?
      true
    end
  end

  def is_editor?
    if is_queen? or self.roles.where(type: "EditorAdminRole").present?
      true
    end
  end


  #20160201 Refactor
  def has_inside_privileges?
    if  self.is_queen? or self.roles.current_as_of(Date.today).where(type: "AdminRole").present? 
      true
    end
  end

  def friends #refactor
    # past_participants = self.projects_organized.joins(:participants).map(&:user)

    # self.projects_organized.joins(:participants).where.not(participants: {user_id: nil}).map(&:project_id)
    # self.projects_organized.project_friends
  end



   def can_view_unpublished?(post)
    if self.is_queen? or self.is_editor?
      true
    elsif post.author.user.id == self.id 
      true
    else
      false
    end
  end

  def has_social_access_for?(social_account)
    if self.is_queen? 
      true
    elsif self.social_accounts.where(social_account_id: social_account.id).present?
      true
    else
      false
    end

  end

  def on_email_list(email_kind_id)
    self.email_lists.where(email_kind_id: email_kind_id).present?
  end

  # def managed_social_shares
  #  self.manged_social_shares
  # end


    after_create :add_new_user_defaults

  private


 

  def add_new_user_defaults
    AddNewUserDefaultsJob.perform(self)
  end


  # def tweet(tweet)
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = Rails.application.config.twitter_key
  #     config.consumer_secret     = Rails.application.config.twitter_secret
  #     config.access_token        = oauth_token
  #     config.access_token_secret = oauth_secret
  #   end
    
  #   client.update(tweet)
  # end



end
