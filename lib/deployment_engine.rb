require 'net/smtp'

module DeploymentEngine

  # PERFECT_GIT_STATUS = "On branch %s\n" + 
  #     "Your branch is up-to-date with 'github/%s'.\n" +
  #     "nothing to commit, working directory clean"
  
  # BEHIND_GIT_STATUS = "On branch %s\n" +
  #     "Your branch is behind 'github/%s' by 1 commit, and can be fast-forwarded.\n" +
  #     "  (use \"git pull\" to update your local branch)\n\n" +
  #     "nothing to commit, working directory clean"

  # # Utility method to make it easier to perform multiple steps interactively

  # def ask_then_do(description)
  #   puts
  #   puts "Next step is: #{description}"
  #   begin
  #     print "Press [A] to proceed, [S] to skip, [Q] to quit --> "
  #     case choice = STDIN.gets.strip.downcase[0]
  #       when 'a'
  #         yield
  #       when 'q'
  #         fail 'Quit by user'
  #     end
  #   end until 'asq'.include? choice
  # end


  # def do_step(command)
  #   ask_then_do(command) {puts `#{command}`}
  # end


  # # Find the current branch (but only check once)

  # def branch
  #   @current_branch ||= `git branch`.lines.find{|i|i[0]=='*'}[2,99].strip.downcase.to_sym
  # end


  # # Find the current build number (but only check once)

  # def build_number
  #   @build_number ||= File.open('build_number').read.strip
  # end

  # def app_name
  #   @app_name ||= Rails.application.class.parent_name
  # end

  # def announcement_text(environment)
  #   "Deploying #{build_number} of #{app_name} " +
  #      "from the #{branch} branch to the #{environment} environment"
  # end

  # def final_text(environment)
  #   "Deployment complete\nVersion #{build_number} of #{app_name} " +
  #      "has been deployed to the #{environment} environment"
  # end


  # # Check the git status to see if we are ready to deploy

  # def ready_to_deploy(environment)
  #   environment = environment.to_s.downcase
  #   if `git status`.strip == PERFECT_GIT_STATUS % ([branch] * 2) or
  #     `git status`.strip == BEHIND_GIT_STATUS % ([branch] * 2)
  #     puts 
  #     print "Type '#{environment}' to proceed --> "
  #     STDIN.gets.strip.downcase == environment
  #   else
  #     puts "You cannot deploy because of git status:"
  #     puts `git status`
  #     false
  #   end
  # end


  # def deploy_to(environment)
  #   if ready_to_deploy(environment)
  #     #ask_then_do("(send start email)") {send_email(announcement_text(environment))}
  #     do_step("heroku maintenance:on --remote #{environment}")
  #     do_step("git push #{environment} #{branch}:master")
  #     yield
  #     do_step("heroku maintenance:off --remote #{environment}")
  #     puts "Deployment script is complete. Review output above to determine success."
  #     #ask_then_do("(send final email)") {send_email(final_text(environment))}
  #   end
  # end


  # # Sends a very simple email from the current Git user to the ops
  # # group. Assumes the first line of the email is the subject.

  # def send_email(message)
  #   @email_from ||= `git config --get user.email`.strip
  #   @email_from_full ||=  "#{`git config --get user.name`.strip} <#{@email_from}>"
  #   @email_to ||= app_name.underscore.dasherize + 'ops@octopusplanner.com'
  #   @email_to_full ||= "#{app_name.humanize} Operations Team <#{@email_to}>"
  #   full_message = "From: #{@email_from_full}\nTo: #{@email_to_full}\n" +
  #     "Subject: #{message.lines.first.strip}\n\n#{message}\n\n" +
  #     "This is an automated message from the build system."
  #   Net::SMTP.start('aspmx.l.google.com', 25) do |smtp|
  #     smtp.send_message full_message, @email_from, @email_to
  #   end
  # end

end
