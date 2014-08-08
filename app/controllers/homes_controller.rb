class HomesController < ApplicationController
  included ActionController::MimeResponds
  before_action :authenticate_user!, :only => [:index]
  before_action :set_hightlight
  authorize_resource :class => false 
  def index
  end

  def setLanguage
    session[:language]=params[:val]
    render json: {val:params[:val]}
  end
  private
  def set_hightlight
    session[:menustatus] = 'home';
  end
end

