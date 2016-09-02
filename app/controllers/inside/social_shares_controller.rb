class Inside::SocialSharesController < Inside::DashboardController
  include InsidesHelper
  include ApplicationHelper

  before_action :authenticate_user!
  before_action :authenticate_inside_privileges

  before_action :set_social_share, except: [:index, :new]
  # before_filter :load_tweets




  layout 'inside'


  def load_tweets
    @tweets = Twitter.user_timeline[0..4] # For this demonstration lets keep the tweets limited to the first 5 available.
  end

  def tweets

  end

  def post_tweet(social_share)
    
    Twitter.update(social_share.tweet)

    # twitter.update("@BenMorganIO taught me how to tweet with the Twitter API!")

  end

  def index
    if current_user.is_queen?
      @social_shares = SocialShare.order(scheduled_datetime: :asc).all
    else
      social_accounts = current_user.social_accounts
      @social_shares = SocialShare.by_account_access(social_accounts).all
    end
  end

  # def new 
  #   @image = BlogImage.new
  # end

  # def show
  # end

  # def edit

  # end

  # def create
  #    @image = BlogImage.new(blog_image_params)
  #    respond_to do |format|
  #     if @image.save 
  #       format.html {redirect_to inside_blog_image_path(id: @image.id), notice: "Photo was successfully created." and return}
  #       format.json { render :edit, status: :created, location: @image and return }
  #     else
  #       format.html { render :new and return }
  #       format.json { render json: @image.errors, status: :unprocessable_entity and return }
  #     end
  #   end
  # end


  # def destroy
  #   @image.destroy
  #   respond_to do |format|
  #     format.html { redirect_to inside_blog_images_path, notice: 'Photo was successfully deleted.' }
  #     format.json { head :no_content }
  #   end
  # end

  def update
    respond_to do |format|
     if @social_share.update_attributes(social_share_params)  
        format.html {redirect_to inside_blog_image_path(id: @image.id), notice: "Photo was successfully updated." and return}
        format.json { render :edit, status: :created, location: @image and return }
      else
        format.html { render :edit and return }
        format.json { render json: @image.errors, status: :unprocessable_entity and return }
      end
    end
  end

  private

  def set_social_share
    @social_share = SocialShare.find(params[:id])
  end

  def social_share_params
        params.require(:social_sharing).permit(:id, )
  end


end
