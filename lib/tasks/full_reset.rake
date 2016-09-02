require 'fileutils'

namespace :full_reset do


  # On alpha, run heroku pg:reset DATABASE first

  task alpha: [
    # :'storage:delete:all',
    :'db:schema:load',
    :'db:foundation_data',
    :'db:blog_foundation_data',
    :'db:blog_sample_data',
    :'db:sample_data'


  ] 

  # On dev, we replace the database ourself

  task dev: [
    :'db:drop', 
    :'db:create', 
    :alpha
  ]

end
