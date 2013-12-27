class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :encrypted_password
  validates_format_of :email, :with =>/\A[^@\s,]+@[^@\s\.]+\.[a-zA-Z]+\z/
end
