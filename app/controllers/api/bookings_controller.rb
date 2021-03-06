class Api::BookingsController < Api::ApiController
  def index
    begin
      @users = Condo.find(User.find(params[:user_id]).condo_id).users
      arr_group_id  = []
      @users.each do |user|
        arr_group_id << user.id
      end
    rescue
      return render json: PublicFunction.data_json('failed', 'user_id not found', 0, nil)
    end
    begin
      @booking_facilities = []
      FacilityCategory.all.each do |cate|
        temp = {}
        temp[:category_id] = cate.id
        temp[:category] = cate.name
        fc_temp = Facility.where("active=true and user_id in (#{arr_group_id.join(',')}) and facility_category_id=#{cate.id}")
        temp[:facilities] = process_results fc_temp
        @booking_facilities << temp
      end
      # @booking_facilities = Facility.where("active=true and user_id in (#{arr_group_id.join(',')})")
      if @booking_facilities.size > 0
        return render json: PublicFunction.data_json('success', 'Facility list', @booking_facilities.size, @booking_facilities)
      else
        return render json: PublicFunction.data_json('failed', 'Facility list', 0, nil)
      end
    rescue
      return render json: PublicFunction.data_json('failed', 'Load facility error', 0, nil)
    end

  end

  def get_facilities
    if !params[:condo_id].nil?
      limit = params[:limit].blank? ? 5 : params[:limit].to_i
      page = params[:page].blank? ? 1 : params[:page].to_i
      facility_category = params[:facility_category].blank? ? nil : params[:facility_category].to_i
      if facility_category.nil?
        total_correct = Condo.find(params[:condo_id]).facilities.where(:active => true)
        facilities = Condo.find(params[:condo_id]).facilities.where(:active => true).limit(limit).offset((page - 1) * limit).order('created_at' => :desc)
      else
        total_correct = Condo.find(params[:condo_id]).facilities.where(facility_category_id: facility_category, :active => true)
        facilities = Condo.find(params[:condo_id]).facilities.where(facility_category_id: facility_category, :active => true).limit(limit).offset((page - 1) * limit).order('created_at' => :desc)
      end
      facilities = process_results facilities
      return render json: PublicFunction.data_json('success', 'List facility', total_correct.size, facilities)
    else
      return render json: PublicFunction.data_json('failed', 'Missing condo_id parameter', 0, nil)
    end
  end


  def count_facility
    if !params[:condo_id].nil?
      return render json: PublicFunction.data_json('success', 'List facility', 1, Condo.find(params[:condo_id]).facilities.size)
    else
      return render json: PublicFunction.data_json('failed', 'Missing condo_id parameter', 0, nil)
    end
  end

  def get_facility_categories
    if !params[:condo_id].nil?
      facility_categories = Condo.find(params[:condo_id]).facility_categories.order(name: :desc)
      return render json: PublicFunction.data_json('success', 'List facility', facility_categories.size, facility_categories)
    else
      return render json: PublicFunction.data_json('failed', 'Missing condo_id parameter', 0, nil)
    end
  end

  def make_a_booking
    if !params[:user_id].nil? && !params[:preferred_date].nil? && !params[:time_slot_id].nil?
      if Booking.where(date_book:params[:preferred_date].to_date, time_slot_id:params[:time_slot_id]).size > 0
        return render json: PublicFunction.data_json('failed', t('bookings.booking_existed'), 0, nil)
      end
      if TimeSlot.where(id:params[:time_slot_id]).size == 0
        return render json: PublicFunction.data_json('failed', t('bookings.time_slot_not_exist'), 0, nil)
      end
      temp = Hash.new
      temp[:facility_name] = TimeSlot.find(params[:time_slot_id]).facility.name
      temp[:user_name] = User.find(params[:user_id]).name.blank? == true ? User.find(params[:user_id]).username : User.find(params[:user_id]).name
      time_slot = TimeSlot.find(params[:time_slot_id])
      temp[:time_slot] = time_slot.slot_start.strftime("%H:%M") + ' - ' + TimeSlot.find(params[:time_slot_id]).slot_end.strftime("%H:%M")
      temp[:booking_price] = time_slot.facility.booking_price
      temp[:deposit_price] = time_slot.facility.deposit_price
      @booking = Booking.create(data:temp.to_s,time_slot_id:params[:time_slot_id], date_submit:Time.now , date_expiry:1.days.from_now , date_book:params[:preferred_date], user_id:params[:user_id], status:'Waiting')
      if @booking
        return render json: PublicFunction.data_json('success', t('bookings.booking_success'), 1, @booking)
      else
        return render json: PublicFunction.data_json('failed', t('bookings.booking_unsuccess'), 0, nil)
      end
    else
      return render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
    end
  end

  def my_bookings
    user = params[:user_id]
    if user.nil?
      return render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
    else
      if User.where(id: user).size > 0
        @booking = User.find(user).bookings
        return render json: PublicFunction.data_json('success', 'Check booking list', @booking.size, @booking)
      else
        return render json: PublicFunction.data_json('failed', 'User_id not found', 0, nil)
      end
    end
  end

  def check_booking
    user = params[:user_id]
    if user.nil?
      return render json: PublicFunction.data_json('failed', 'Missing parameter', 0, nil)
    else
      if User.where(id: user).size > 0
        @booking = User.find(user).bookings
        @facilities = []
        i=0
        @booking.each do |book|
          temp = Hash.new
          if !book.time_slot.nil?
          temp[:name]= book.facility.name
          temp[:booking_price]= book.facility.booking_price
          temp[:deposit_price]= book.facility.deposit_price
          temp[:note]= book.facility.note
          temp[:image_path]= book.facility.image_path.url
          temp[:status]=book.status
          temp[:book_id] = book.id
          temp[:facility_category_id]=book.facility.facility_category_id
          begin
            cate = FacilityCategory.find(book.facility.facility_category_id).name
          rescue
            cate = ""
          end
          temp[:facility_category_name]=cate
          end
          @facilities[i] = temp
          #temp[b.status] = b.status
          #facilities[i][:ok] = 'ok'
          i+=1
        end
        # facilities[0].status = 'booked'
        return render json: PublicFunction.data_json('success', 'Check booking list', @facilities.size, @facilities)
      else
        return render json: PublicFunction.data_json('failed', 'User_id not found', 0, nil)
      end
    end
  end

  def booking_detail
    if params[:booking_facility_id].nil?
      return render json: PublicFunction.data_json('failed', 'Missing parameter \'booking_facility_id\'', 0, nil)
    end
    begin
      temp = {}
      temp[:facility] = process_result Facility.find(params[:booking_facility_id])
      temp[:time_slots] = Facility.find(params[:booking_facility_id]).time_slots.nil? ? nil : Facility.find(params[:booking_facility_id]).time_slots
      return render json: PublicFunction.data_json('success', 'Show booking facility detail!', 1, temp)
    rescue
      return render json: PublicFunction.data_json('failed', 'Error!', 0, nil)
    end
  end

  def delete_my_booking
    if params[:booking_id].nil? || params[:booking_id].blank?
      return render json: PublicFunction.data_json('failed', 'Missing parameter \'booking_id\'', 0, nil)
    end
    begin
      if Booking.where(id:params[:booking_id]).size > 0
        Booking.destroy(Booking.find(params[:booking_id]))
        return render json: PublicFunction.data_json('success', 'Delete booking was success!', 1, {})
      else
        return render json: PublicFunction.data_json('failed', 'booking_id not found!', 0, nil)
      end
    rescue
      return render json: PublicFunction.data_json('failed', 'Error delete booking!', 0, nil)
    end
  end

  private
  def process_results results=nil
      booking_data=[]
      i=0
      results.each do |booking|
        temp = Hash.new
        temp[:id]= booking.id
        temp[:user_id]= booking.user_id
        temp[:name]= booking.name
        temp[:booking_price]= booking.booking_price
        temp[:deposit_price]=booking.deposit_price
        temp[:note]=booking.note
        temp[:active]=booking.active
        temp[:created_at]=booking.created_at
        temp[:updated_at]=booking.updated_at
        temp[:facility_category_id]=booking.facility_category_id
        temp[:image_path]=booking.image_path.url(:default)
        booking_data[i] = temp
        i+=1
      end
      return booking_data
  end

  def process_result facility=nil
      temp = Hash.new
      temp[:id]= facility.id
      temp[:user_id]= facility.user_id
      temp[:name]= facility.name
      temp[:booking_price]= facility.booking_price
      temp[:deposit_price]=facility.deposit_price
      temp[:note]=facility.note
      temp[:active]=facility.active
      temp[:created_at]=facility.created_at
      temp[:updated_at]=facility.updated_at
      temp[:facility_category_id]=facility.facility_category_id
      temp[:image_path]=facility.image_path.url(:default)
    return temp
  end
end

