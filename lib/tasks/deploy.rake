require 'deployment_engine'

namespace :deploy do

  include DeploymentEngine


  namespace :version do
    task :capture do
      do_step("git add build_number; git commit -m `cat build_number`; git push")
    end
  end


  task :alpha do
    if [:master,:hotfix,:alpha,:beta].include?(branch)
      deploy_to :alpha do
        do_step("heroku pg:reset DATABASE --confirm oct-alpha --remote alpha")
        do_step("heroku run rake full_reset:alpha --trace --remote alpha")
      end
    end
  end

  # task :beta do
  #   if branch==:beta 
  #     deploy_to :beta do
  #       do_step("heroku pg:copy hgx-harare-prod::DATABASE DATABASE " +
  #         "--confirm hgx-harare-beta --remote beta")
  #       do_step("heroku run rake db:migrate --trace --remote beta")


  #       # At some point we want to perform the storage copy in
  #       # detached mode, but for now it makes sense to keep an eye on
  #       # it.

  #       do_step("heroku run rake storage:copy:prod --trace --remote beta")


  #       # We should probably find a softer way to get the latest update migration
  #       #do_step("heroku run rake deploy:v000400 --trace --remote beta")


  #       do_step("heroku run:detached rake legacy:migrate:old --trace --remote beta")
  #     end
  #   end
  # end


  task :prod do
    if branch==:prod
      deploy_to :prod do
        do_step("heroku pg:backups capture DATABASE " +
          "--confirm oct-prod --remote prod")
        do_step("heroku run rake db:migrate --trace --remote prod")


        # Insert some kind of storage backup here


        # We should probably find a softer way to get the latest update migration
        #do_step("heroku run rake deploy:v000400 --trace --remote prod")


        #do_step("heroku run:detached rake legacy:migrate:old --trace --remote beta")
      end
    end
  end


  # We did not deploy to Prod between v0.3.0 and v0.4.0 so we need to
  # carry forward the deployment scripts.
  #  task v000600: [
  #   :v000300,
  #   :v000400,
  #   :v000500,
  #   :'db:sample_cardholders_v6',
  #   :'db:redo_product_ratings_v6',
  #   :'db:susan_soarer_v6'

  #  ]
  #  task v000500: [
  #   :v000300,
  #   :v000400,
  #   :'db:add_sections_v5',
  # ]

  # task v000400: [
  #   :v000300,
  #   :'db:data_fix_v4', 
  #   :'db:adding_school_instructors_v4',
  #   :'db:adding_sample_media_v4',
  #   :'db:fix_ratings_end_v4',
  #   :'db:add_sample_card_batches_v4'
  # ]


  # # Specific tasks required for version 0.3

  # task v000300: [
  #   :'db:special_pages', 
  #   :'db:fix_nav_images',
  #   :'db:add_ads',
  #   :'datafixes:update_link_lists',
  #   :'admin:make_all_admins_authors_and_staff',
  # ] do
  #   print "Loading countries..."
  #   YAML.load_file('db/countries.yml').each { |country| Country.create!(country) }
  #   puts "Done"
  #   print "Making chapter-resources and board-reports foundational..."
  #   Page.where(slug:['chapter-resources','board-reports']).each do |p|
  #     p.is_foundation=true
  #     p.save
  #   end
  #   puts "Done"
  # end
end
