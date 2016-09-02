class EditorAdminRole < AuthorAdminRole



  def can_make_roles
    [
      AuthorAdminRole,  
      # EditorAdmin, 
      # WriterAdmin,
      # FinanceAdmin,
      # InvestorAdmin
    ]
  end

 

  
end
