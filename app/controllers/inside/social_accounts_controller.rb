class Inside::BlogImagesController < Inside::DashboardController
  before_action :authenticate_user!
  before_action :authenticate_inside_privileges

  before_action :set_blog_image, except: [:index, :new]

  include InsidesHelper
  include ApplicationHelper


  layout 'inside'

  # def index
  #   @images = BlogImage.all
  #   @images = @images.page params[:page]
  # end

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

  # def update
  #   respond_to do |format|
  #    if @image.update_attributes(blog_image_params)  
  #       format.html {redirect_to inside_blog_image_path(id: @image.id), notice: "Photo was successfully updated." and return}
  #       format.json { render :edit, status: :created, location: @image and return }
  #     else
  #       format.html { render :edit and return }
  #       format.json { render json: @image.errors, status: :unprocessable_entity and return }
  #     end
  #   end
  # end

  # private

  # def set_blog_image
  #   @image = BlogImage.find(params[:id])
  # end

  # def blog_image_params
  #       params.require(:blog_image).permit(:id, :landscape_media,   :editor_user_id, :portrait_media, :type, :title, :media, 
  #         :description, :caption, :status, :license, :octopus_owned, :owner_name, :owner_link, :owner_site_name, :media_link)
  # end


end
