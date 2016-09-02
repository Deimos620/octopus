class ProjectRestriction < ActiveRecord::Base
  belongs_to :project
  belongs_to :restriction

end
