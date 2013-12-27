class Genre < ActiveRecord::Base
  validates_presence_of :name

  has_many :prose_tags
  has_many :proses, :through=>:prose_tags
end
