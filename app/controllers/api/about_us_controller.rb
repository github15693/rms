class Api::AboutUsController < Api::ApiController
  skip_before_action :authenticate_user_from_token!

  def about_us
    @about_us = AboutUs.first
    unless @about_us.nil?
      render json: {status: 'success', message: 'About Us found', results: @about_us}
    else
      render json: {status: 'failed', message: 'About Us not found', results: {}}
    end
  end
end

