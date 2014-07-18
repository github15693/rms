class FacilitiesController < ApplicationController


before_action :set_hightlight
 respond_to :json ,:html, :js
def index
	@facilities = current_user.condo.facilities
end




 def new
    @facility = Facility.new
    @cat = current_user.condo.facility_categories
 end



  def confirm
    @facility = Facility.find(params[:facility_id])
  end


   def update
   	   if params[:facility][:image]
   	   	@image = true
   	   else
   	   	@image = false 
   	   end
   	@facilities = current_user.condo.facilities
   @facility = Facility.find(params[:id])
   @facility.update_attributes(facility_params)

  end
  def change_active
  	 @facility = Facility.find(params[:id])
  	 @facility.active = params[:active]
  	 @facility.save
  	 render json: {data:"test"}
  end	

  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy
    @facilities = current_user.condo.facilities
  end


 def create


    @facility = Facility.create(facility_params)

    @facilities = current_user.condo.facilities
  end
 def edit
 	@facility = Facility.find(params[:id])
 	 @cat = current_user.condo.facility_categories
 end
 def facility_params
      params.require(:facility).permit(:name, :booking_price, :deposit_price, :note, :image,:facility_category_id)
    end

  def set_hightlight

    session[:menustatus] = 'facilities'
  end

end

