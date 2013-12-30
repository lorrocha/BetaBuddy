class Genre < ActiveRecord::Base
  validates_presence_of :name

  has_many :prose_tags, :dependent => :destroy
  has_many :proses, :through=>:prose_tags
end
