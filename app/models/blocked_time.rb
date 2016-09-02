class BlockedTime < ActiveRecord::Base
  belongs_to :project_date

  def time_start_formatted
    self.time_start.strftime("%l:%M %P")
  end

  def time_end_formatted
    self.time_end.strftime("%l:%M %P")
  end
  
end
