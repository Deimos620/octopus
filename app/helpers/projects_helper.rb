module ProjectsHelper

  def default_country
    return Country.find_by(name: "United States").id
  end

 def sample_particpant_role(type)
    ParticipantRole.new(type: type)
  end

  # 

  def parsing_roles(participant_role)
    # participant_role = participant_role
    if participant_role == 1
       'OrganizerParticipantRole'
     elsif participant_role == 2
      'RecipientOrganizerParticipantRole'
    elsif participant_role == 3
      'RecipientParticipantRole'
    elsif participant_role == 4
      'HelperParticipantRole'
    else
      'HelperParticipantRole'
    end
  end

  def participant_code_to_type(code)
    # participant_role = participant_role
    if code == 1
       'OrganizerParticipantRole'
     elsif code == 2
      'RecipientOrganizerParticipantRole'
    elsif code == 3
      'RecipientParticipantRole'
    elsif code == 4
      'HelperParticipantRole'
    else
      'HelperParticipantRole'
    end
  end

  def project_code_to_type(code)
    case code ? code.to_i : nil
      when 1
        "NewBabyMealDeliveryProject"
      when 2
        "WeddingPartyProject"
      # when 3
      #   "NewBabyMealDeliveryProject"

      # when 4
      #   "NewBabyMealDeliveryProject"

      # when 5
      #   "MealDeliveryProject"
      # when 6
    end
  end

  def participant_title_code_to_title(code)
    case code ? code.to_i : nil
      when 1
        "Bride"
      when 2
        "Groom"
      # when 3
      #   "NewBabyMealDeliveryProject"

      # when 4
      #   "NewBabyMealDeliveryProject"

      # when 5
      #   "MealDeliveryProject"
      # when 6
    end
  end

  def project_type_to_code(type)
    case type ? type.to_s : nil
      when "NewBabyMealDeliveryProject"
           1
      # when 2

      #   "WeddingPartyProject"
      # when 3
      #   "NewBabyMealDeliveryProject"

      # when 4
      #   "NewBabyMealDeliveryProject"

      # when 5
      #   "MealDeliveryProject"
      # when 6
    end
  end

  def max_visits_menu
   [
    ['No Maximimum', '1000'],
    ['1', '1'],
    ['2', '2'],
    ['3', '3'],
    ['4', '4'],
    ['5', '5']
  ]
end

  

def set_to_active(project)
  if project.draft? or project.archived?
    project.status = "active"
    project.save 
  end
end

def project_categories
 Project.subclasses
end

def meal_delivery_kinds
  MealDeliveryProject.subclasses
end

def party_kinds
  PartyProject.subclasses
end

def wedding_kinds
  PartyProject.subclasses #add qualifier
end

def shower_kinds
  PartyProject.subclasses #add qualifier
end

def other_party_kinds
  PartyProject.subclasses #add qualifier
end

def setup(source, project)
  case source ? source.to_s : nil
    when "restrictions"
      project_add_restrictions_path(id: project.id, project_id: project.id, )
    when "verify dates"
      project_available_dates_path(id: project.id)
    when "show project"
      project_path(id: project.id)
    when "new project"
      project_add_restrictions_path(id: project.id, project_id: project.id, )
    else
      project_path(id: project.id)
    end
end



end
