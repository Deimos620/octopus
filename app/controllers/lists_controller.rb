class ListsController < DashboardController
      include ListsHelper

  before_action :store_location
  before_action :authenticate_user!
  before_action :set_list, only: [:destroy, :update, :show, :edit]
  before_action :set_nested_project, only: []
  [Project,  ParticipantRole, Role, List] if Rails.env == 'development'
  before_action :set_current_user_participation,  only: []

  
  layout 'application'
  respond_to :html

  def index
    #make so it can be privilege lists too
    @lists_created = current_user.lists
    # @lists_participating = current_user.participating_lists
  end

  def list_types

  end

  def new
    @list = List.new(user_id: current_user.id)
  end

  def edit

  end

  def import
    Contact.import(params[:file], params[:list_id], current_user.id, params[:auto_add_to_list], params[:import_source])
    FindHouseholdsJob.perform(current_user)
    redirect_to import_results_url(list_id: params[:list_id]), notice: "Recipients imported."
  end

  def show
    @guest_lists = ListRecipient.where(list_id: @list.id)
  end

  def recipients

  end

  def add_recipients

  end

  def create
    @list = List.new(list_params)
    
    respond_to do |format|
      if @list.save
        format.html { redirect_to mailing_list_path(@list), notice: "#{@list.name}  was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_restrictions/1
  # PATCH/PUT /project_restrictions/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: "#{@list.name}  was successfully saved." }
        format.json { render :show, status: :ok, location: @project_restriction }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

private  

  def set_list
    @list = List.find(params[:id])
  end

    def list_params
       params.require(:list).permit(:id, :editor_participant_id, :user_id, :project_id, :type, :limit,
                 :custom_name, :rsvp_needed, :status, :has_meals
                 )
                                      
    end
end
