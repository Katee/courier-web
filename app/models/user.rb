class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :client_id

  has_many :jobs
  belongs_to :client

  after_create :welcome_email

  def login_url
    new_user_session_path(:email => self.email)
  end

  private
    def welcome_email
      UserMailer.welcome_email(self).deliver
    end
end
