class HomeController < ApplicationController
	before_action :authenticate_user!
  def index
     @user = current_user
    if current_user.role.name == 'Doctor'
      @patients = User.where(:role_id => 1) 
    end
  end

  def reports 
    if params[:user]
       @user = JSON.parse(params[:user])
       @user = User.find(@user["id"])
    end
   	current_user.role.name == 'Patient' ? (@user = current_user)  : (@user = @user)
   	if params[:report] == 'daily'
  	@date = Date.parse(params[:dateval])
  	@dailyreport = @user.measurements.where(:created_at =>(@date.beginning_of_day..@date.end_of_day))
  	elsif params[:report] == 'monthtodate'
  	@date = Date.parse(params[:dateval])
  	@monthtodatereport = @user.measurements.where(:created_at =>(@date.beginning_of_month..@date.end_of_day))
  	elsif params[:report] == 'monthly'
  	 monthval = params[:monthval].to_i
  	 yearval = params[:yearval].to_i
  	@monthlyreport = @user.measurements.where(:created_at => (Date.new(yearval,monthval,1)..Date.new(yearval,monthval,-1)))
  	end
  	render :partial => 'reports',:locals => {:report => params[:report]}
  end

  def patient_report
    @patient = params[:id]
    @user = User.find(@patient)
  end


end
