class AuthorAdminRole < AdminRole

  def self.types
    [
      AuthorRole.types
      
    ].flatten
  end
 
end
