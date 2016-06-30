class MeasurementsController < ApplicationController
     before_action :authenticate_user!
     before_action :set_user
	def index
		@measurements = @user.measurements.all
	end

	def new
	   @measurement = @user.measurements.new
    end


  def create
    @measurement = @user.measurements.new(measurement_params)
    if @measurement.save
      flash[:success] = "Readings entered"
 		 redirect_to @measurement
    else 
     render :action => 'new'
    end
	end

	def show
		@measurement = @user.measurements.find(params[:id])
	end

    def edit
    	@measurement = @user.measurements.find(params[:id])
    end

    def update
    	@measurement = @user.measurements.find(params[:id])
    	if @measurement.update_attributes(measurement_params)
    		redirect_to @user,:notice => "Readings updated"
    	else
    		render :action => 'new'
    	end
    end

    def destroy
    	@measurement = @user.measurements.find(params[:id])
    	@measurement.destroy
    end

    def reports
      @dailyreport = @user.measurements.where(:created_at =>(Time.zone.now.beginning_of_day..Time.zone.now.end_of_day))
      #@monthtodate = @user.measurements.where()
      #@monthlyreport = @user.measurements.where()
      render :partial => 'reports'
    end

  private

  def set_user
  	@user = current_user
  end

   def measurement_params
   	 params.require(:measurement).permit(:measured_value,:measured_at)
   end
end
