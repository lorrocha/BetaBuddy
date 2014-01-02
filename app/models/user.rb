class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username
  validates_presence_of :encrypted_password
  validates_format_of :email,
   :with =>/\A[^@\s,]+@[^@\s\.]+\.[a-zA-Z]+\z/
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  has_many :proses, :inverse_of => :user

  def is_admin?
    role == 'admin'
  end
end
