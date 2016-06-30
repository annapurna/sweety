class Measurement < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :measured_value,:measured_at
	validates_numericality_of :measured_value,:only_integer => true 
	validate :should_not_exceed_max, :on => :create
	

	private
	def should_not_exceed_max
		if user.measurements.today.count >= 4
			errors.add(:readings, "crossed maximum limit of the today!")
		end
	end
 
end
