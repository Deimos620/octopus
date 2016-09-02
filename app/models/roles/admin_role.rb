class AdminRole < Role

  belongs_to :user
  belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"

  def self.types
    [
      AdminRole.types,
      QueenAdminRole, 
      AuthorAdminRole,  
      # SocialAdminRole, 
      # CuratorAdminRole
      EditorAdminRole

    ].flatten
  end

  def can_edit
    true
  end

  

  
end
