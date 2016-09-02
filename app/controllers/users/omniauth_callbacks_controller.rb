class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  prepend_before_filter :require_no_authentication
  layout 'application'

def google_oauth2
  @user = User.from_omniauth(request.env["omniauth.auth"])
  @user.save
    if @user.persisted? 
      flash.notice = "Account Created! Please Check Your Email for a Confirmation."
      # redirect_to after_inactive_sign_up_path_for(user)
      sign_in @user
      redirect_to projects_path
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end


end

def facebook
  @user = User.from_omniauth(request.env["omniauth.auth"])
  @user.save
    if @user.persisted? 
      flash.notice = "Account Created! Please Check Your Email for a Confirmation."
      # redirect_to after_inactive_sign_up_path_for(user)
      sign_in @user
      redirect_to projects_path
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end

end

  def after_inactive_sign_up_path_for(resource)
    signup_success_path
  end


  # def self.from_omniauth(access_token)
  #     data = access_token.info
  #     user = User.where(:email => data["email"]).first

  #     # Uncomment the section below if you want users to be created if they don't exist
  #     unless user
  #         user = User.create(name: data["name"],
  #            email: data["email"],
  #            password: Devise.friendly_token[0,20]
  #         )
  #     end
  #     user
  # end
  #   def google_oauth2
  #     # You need to implement the method below in your model (e.g. app/models/user.rb)
  #     @user = User.from_omniauth(request.env["omniauth.auth"])

  #     if @user.persisted?
  #       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
  #       sign_in_and_redirect @user, :event => :authentication
  #     else
  #       session["devise.google_data"] = request.env["omniauth.auth"].except("extra")
  #       redirect_to new_user_registration_url
  #     end
  # end

  # def after_sign_in_path_for(resource)
  #   projects_path
  # end

  #   def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

# def all
#   user = User.from_omniauth(request.env["omniauth.auth"])
#   if user.persisted?
#     flash.notice = "Signed in!"
#     sign_in_and_redirect user
#   else
#     session["devise.user_attributes"] = user.attributes
#     redirect_to new_user_registration_url
#   end
#   alias_method :twitter, :all
#   alias_method :facebook, :all
#   alias_method :google_oauth2, :all


# end

 # def facebook
 #    # You need to implement the method below in your model (e.g. app/models/user.rb)
 #    @user = User.from_omniauth(request.env["omniauth.auth"])

 #    if @user.persisted?
 #      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
 #      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
 #    else
 #      session["devise.facebook_data"] = request.env["omniauth.auth"]
 #      redirect_to new_user_registration_url
 #    end
 #  end




  
end