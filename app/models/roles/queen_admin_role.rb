class QueenAdminRole < AdminRole

 

  def can_make_roles
    # [
    #   BasicAdmin,  
    #   EditorAdmin, 
    #   WriterAdmin,
    #   FinanceAdmin,
    #   InvestorAdmin
    # ]
  end

  def calculate_end_date
    self.end_date = nil
  end

  
end
