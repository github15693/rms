class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :confirm, :destroy]
  before_action :set_form_catogires, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_highlight
  
  respond_to :html, :js, :json
  authorize_resource
  def index
  end

  def show
    redirect_to Form.find(params[:id]).form_path.url
  end


  def filter
    begin
      @form_category = FormCategory.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @form_category = nil
      set_form_catogires
    end
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.create(form_params)
    @persisted = false
  end

  def edit
  end

  def update
    @form.update_attributes(form_params)
    @persisted = true
  end

  def confirm
  end

  def destroy
    @form.destroy
  end

  private
  def set_form
    @form = Form.find(params[:id])
  end

  def set_form_catogires
    @form_categories = current_user.condo.form_categories
  end

  def form_params
    params.require(:form).permit(:title, :form_path, :form_category_id)
  end

  def set_highlight
    session[:menustatus] = 'forms'
  end
end

