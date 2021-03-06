require 'date'
require 'active_support/time'
class TimetablesController < ApplicationController
	before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  Time.zone = 'Eastern Time (US & Canada)'
  def print
    flash[:notice] = "You successfully printed your timesheet. Please sign and deliver to your manager."
  end
  
  def index
    Time.zone = 'Eastern Time (US & Canada)'
    myid = current_user.id
    @profile = Profile.find_by(user_id: myid)
    if params[:timetable] != nil
			sort_by_date  
    else
			#show all of the users timetables
      @timetables = Timetable.get_user_timetables(myid)
    end
		convert_time
		
  end

  # GET /timetables/1
  def show
    Time.zone = 'Eastern Time (US & Canada)'
		id = params[:id] # retrieve movie ID from URI route
    @timetable = Timetable.find(id) # look up movie by unique ID
  end

  # GET /timetables/new
  def new
    Time.zone = 'Eastern Time (US & Canada)'
		#flag that indicates whether the user currently on a shift
		#prevents a user from spamming the clock in button
    @clocked_in = 1
		
	  @timetable= Timetable.create!(time_in: DateTime.now(), user_id: current_user.id)

	  #@clicked = true #true=>if clicked, disable button, false=>enable button
    #@timetable= Timetable.create!(:time_in=>DateTime.now())	
	
    flash[:notice] = "You have successfully clocked in!"
		redirect_to timetables_path
  end

  # GET /timetables/1/edit
  def edit
    Time.zone = 'Eastern Time (US & Canada)'
		@timetable = Timetable.find(params[:id])
		if @timetable.time_out == nil
			@timetable.update(time_out: DateTime.now())
      @clocked_in = 0
			#reset the clocked_in flag to 0
		end
	end

  def create
    Time.zone = 'Eastern Time (US & Canada)'
    @timetable = Timetable.new(timetable_params)
    if @timetable.save
      redirect_to @timetable, notice: 'Timetable was successfully created.'
    else
       render :new
		end
  end

  # PATCH/PUT /timetables/1
  def update
    Time.zone = 'Eastern Time (US & Canada)'
    if @timetable.update(timetable_params)
      redirect_to timetables_path, notice: 'Timetable was successfully updated.'
    end
  end

  # DELETE /timetables/1
  def destroy
    Time.zone = 'Eastern Time (US & Canada)'
    @timetable.destroy
		flash[:notice]= 'Timetable was successfully destroyed.'
    redirect_to timetables_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
      Time.zone = 'Eastern Time (US & Canada)'
      @timetable = Timetable.find(params[:id])
    end
		
		#Calculates the total hours and total shifts
	  def convert_time
      Time.zone = 'Eastern Time (US & Canada)'
      all_dates = Array.new
      @timetables.each do |x|
        time_in = x.time_in #Clock in
        all_dates.push(time_in.day)
      end
      @total_days = all_dates.uniq.length 
			@total_hours = 0
			temp = 0
			@found_clocked = 0
      @weekly_hours = Array.new(@timetables.length(), 0)
      j = 0 #Current week
      for i in 0..@timetables.length()-1 do
				if @timetables[i].time_out == nil
					@found_clocked = 1
				end
				if @timetables[i].time_out != nil and @timetables[i].time_in != nil
					temp = (@timetables[i].time_out.to_time - @timetables[i].time_in.to_time)
          #Rounding to a quarter: (round(num * 4))/4
          @total_hours += (((temp / 3600)*4).round())/4.0
          @weekly_hours[j] += (((temp / 3600)*4).round())/4.0
          if i == @timetables.length()-1 || (@timetables[i].time_in.strftime("%W") != @timetables[i+1].time_in.strftime("%W"))
            j+=1
          end
				end
			end
			@total_hours = @total_hours.round(2)
		end

    # Only allow a trusted parameter "white list" through.
    def timetable_params
      Time.zone = 'Eastern Time (US & Canada)'
      params.require(:timetable).permit(:time_in, :time_out,:notes, :user_id )
    end
  
		#parses through the form to filter the dates
	  def sort_by_date
      Time.zone = 'Eastern Time (US & Canada)'
		  myid = current_user.id
			fromyear = params[:timetable]["fromdate(1i)"]
      toyear = params[:timetable]["todate(1i)"]
      frommonth = params[:timetable]["fromdate(2i)"]
      tomonth = params[:timetable]["todate(2i)"]
      fromday = params[:timetable]["fromdate(3i)"]
      today = params[:timetable]["todate(3i)"]
      final_from_date = DateTime.new(fromyear.to_i, frommonth.to_i, fromday.to_i)
      final_to_date = DateTime.new(toyear.to_i, tomonth.to_i, today.to_i) 
      @timetables = Timetable.filter_dates(final_from_date,final_to_date,myid)
      @fromdate = final_from_date
      @todate  = final_to_date
		end
  
end
