class Contact < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :subject
  validates_presence_of :description
  validates_format_of :email, with: /\A[^@\s\.]+@[^@\s\.]+\.[a-zA-Z]{1,4}\z/
end
