class EmailKind < ActiveRecord::Base
    has_many :email_logs


  def self.types
    [
      AdminEmailKind,
      UserEmailKind,
      
      ].flatten
  end

    scope :user_email, -> { where(type: "UserEmailKind") }
    scope :admin_email, -> { where(type: "AdminEmailKind") }
    scope :invites, -> { where(category: "invites") }
    scope :meal_delivery, -> { where(project_type: "MealDeliveryProject") }
    scope :any_project, -> { where(project_type: "Project") }
    scope :warnings, -> { where(category: "warnings") }
    scope :roundups, -> { where(category: "roundups") }



    def self.projecttype_roletype_category_label(project_category, participant_role, category, label)
      UserEmailKind.where(category: category).where(project_type: project_category).where(role_type: participant_role).find_by_label(label)|| EmailKind.find(1)
    end

    def self.projecttype_category_label(project_category, category, label)
      UserEmailKind.where(category: category).where(project_type: project_category).find_by_label(label)|| EmailKind.find(1)
    end

    def self.type_category_label(type, category, label)
      EmailKind.where(type: type).where(category: category).find_by_label(label)|| EmailKind.find(1)
    end

    def is_invite?
      self.category == "invites"
    end


    # def self.type_label(type, label)
    #     EmailKind.roundups.where(type: type).find_by_label(label)|| EmailKind.find(1)
    # end




end
