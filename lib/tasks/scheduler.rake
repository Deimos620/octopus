




  task admin_roundup_daily:  :environment do
    AdminRoundupJob.perform("daily")
    puts " finished daily admin roundup"
  end

  task :admin_roundup_weekly => :environment do
    AdminRoundupJob.perform("weekly")
    puts " finished weekly admin roundup"
  end

  task :admin_roundup_monthly => :environment do
    AdminRoundupJob.perform("monthly")
    puts " finished weekly admin roundup"
  end

  task :project_rsvps => :environment do
    ProjectRsvpJob.perform
    puts " project_rsvps"
  end

  task :event_changes => :environment do
    ProjectRsvpJob.perform
    puts " finished checking for appointment changes"
  end



