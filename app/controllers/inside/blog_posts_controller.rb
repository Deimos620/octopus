class Inside::BlogPostsController < Inside::DashboardController
  before_action :authenticate_user!
  before_action :authenticate_inside_privileges

  before_action :set_blog_post, except: [:index, :new]
  before_action :view_unpublished_post, except: [:new]

  [BlogPost] if Rails.env == 'development'

  include InsidesHelper
  include ApplicationHelper


  layout 'inside'

  def index
    @articles = BlogPostOriginal.includes(:author).includes(:blog_editor).all
    @articles = @articles.page params[:page]
  end

  def new 
    @article = BlogPost.new(type: "BlogPostOriginal")
  end

  def show
  end

  def edit

  end

  def create
     @article = BlogPost.new(blog_post_params)
     respond_to do |format|
      if @post.save 
        format.html {redirect_to inside_blog_post_path(id: @article.id), notice: "Post was successfully created." and return}
        format.json { render :edit, status: :created, location: @article and return }
      else
        format.html { render :new and return }
        format.json { render json: @article.errors, status: :unprocessable_entity and return }
      end
    end
  end




  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to inside_blog_posts_path, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
     if @article.update_attributes(blog_post_params)  
        format.html {redirect_to inside_blog_post_path(id: @article.id), notice: "Post was successfully updated." and return}
        format.json { render :edit, status: :created, location: @article and return }
      else
        format.html { render :edit and return }
        format.json { render json: @article.errors, status: :unprocessable_entity and return }
      end
    end
  end

  private

  def set_blog_post
    @article = BlogPost.friendly.find(params[:id])
  end

  def view_unpublished_post
    if current_user.can_view_unpublished?(@post)
      true
    else
      initiate_no_access
    end
  end

  def blog_post_params
        params.require(:blog_post).permit(:id, :title, :editor_user_id, :blog_author_id, :type, :blog_section_id, :original_post_id, 
          :blog_editor_user_id, :blog_feature_id, :lead, :body, :publication_date, :status, :hero_img, :thumbnail_img, :slug)
  end



end
