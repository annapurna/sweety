class User < ActiveRecord::Base
	# => ROLES = %w[patient doctor].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :measurements do 
    
    def today
      where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now))
    end
  end

  validates_presence_of :username, :email, :age
  validates_numericality_of :age,:only_integer => true 
end

