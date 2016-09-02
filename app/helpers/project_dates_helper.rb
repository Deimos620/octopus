module ProjectDatesHelper
  # def taken_times(other_events)
  #   if other_events.present?
  #     other_events.map { |event| [event.time_start.strftime("%l:%M %P"), event.time_end.strftime("%l:%M %P")] }
  #     # other_events.map { |event| [event.time_start, event.time_end] }

  #   end
  # end

  def taken_times(project_date)
    @events = project_date.events
    @blocked_times = project_date.blocked_times 
    other_events =  @blocked_times + @events
    if other_events.present?
      # other_events.map { |event| [event.time_start.strftime("%l:%M %P"), event.time_end.strftime("%l:%M %P")] }
      other_events.map { |event| [event.time_start_formatted, event.time_end_formatted] }
    end
  end


  def unavailable_dates(project_date)
    project = Project.find(project_date.project_id)
    # @available_dates = @project.project_dates.available
    opendates =  ProjectDate.where(project_id: params[:project_id]).where('events_count < ?', project.max_visits)
    @allavailable_dates = project.project_dates.available +  opendates
    eventcountdate =  ProjectDate.where(project_id: params[:project_id]).where('events_count >= ?', project.max_visits)
    @navail_project_dates  =  project.project_dates.unavailable +  project.project_dates.past + eventcountdate 
    unavail_project_dates.map { |date| date.schedule_date.strftime("%m/%d/%Y ")  }
  end

  def default_time_start(project_date)
    project = Project.find(project_date.project_id) 
    project.time_start.strftime("%l:%M %P")
  end


  # def unavailable_dates(unavail_project_dates)
  #   if unavail_project_dates.present?
  #     # unavail_project_dates.map { |date| date.schedule_date.strftime("%m/%d/%Y ")  }
  #     unavail_project_dates.map { |date| date.schedule_date  }

  #   end
  # end
end
