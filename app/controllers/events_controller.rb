class EventsController < ApplicationController
  include ActionController::MimeResponds
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_hightlight
  authorize_resource
  # GET /events
  # GET /events.json
  def index
    if current_user.roles.where(role_name: 'Admin').size > 0
      @events = Event.where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").order(created_at: :desc)
    else
      @events = Event.where(:user_id => current_user.id).order(created_at: :desc)
    end
  end

  def archives
    if current_user.roles.where(role_name: 'Admin').size > 0
      @events = Event.where(archived: 1).where("user_id in (#{User.where(:condo_id => current_user.condo_id).select('id').map(&:id).join(',')})").order(created_at: :desc)
    else
      @events = Event.where(:user_id => current_user.id, archived: 1).order(created_at: :desc)
    end
  end

  def archive
    begin
      Event.find(params[:id]).update(archived: 1)
      @event_id = params[:id]
       return @rs = 1
    rescue
      return @rs = 0
    end
  end

  def unarchive
    begin
      Event.find(params[:id]).update(archived: 0)
      @event_id = params[:id]
      return @rs = 1
    rescue
      return @rs = 0
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event_image = @event.event_images
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    @condo = Condo.all
    @event_image = EventImage.new
  end

  # GET /events/1/edit
  def edit
    @condo = Condo.all
    @event_image = @event.event_images
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    if current_user.roles.where(role_name: 'Admin').size > 0
      @events = Event.all.order(created_at: :desc)
    else
      @events = Event.where(:user_id => current_user.id).order(created_at: :desc)
    end
    respond_to do |format|
      if @event.save
        if params[:event][:image]
          params[:event][:image].each do |image|
            @event.event_images.create(:image => image)
          end
        end
        format.html { redirect_to events_path, notice: t('common.successfully_created') #redirect_to @event
        }
        format.json {#render :show, status: :created, location: @event
        }
        format.js
      else
        format.html {
        }
        format.json {# render json: @event.errors, status: :unprocessable_entity
        }
        format.js
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if current_user.roles.where(role_name: 'Admin').size > 0
      @events = Event.all.order(created_at: :desc)
    else
      @events = Event.where(:user_id => current_user.id).order(created_at: :desc)
    end
    respond_to do |format|
      if @event.update(event_params)
        if params[:image_id]
          params[:image_id].each do |image_id|
            @event_image= EventImage.find(image_id).destroy
          end
        end
        if params[:event][:image]
          params[:event][:image].each do |image|
            @event.event_images.create(:image => image)
          end
        end
        format.html { redirect_to events_path, notice: t('common.successfully_created') #redirect_to @event
        }
        format.json { render :show, status: :ok, location: @event }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: t('common.successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :date, :event_start, :event_end, :location, :organiser, :description, :user_id)
  end

  def set_hightlight
    session[:menustatus]='events'
  end
end

