class Prose < ActiveRecord::Base
  validates_numericality_of :user_id, :only_integer=>true
  validates_numericality_of :current_state, :only_integer=>true
  validates_presence_of :description

  has_many :prose_tags, :dependent => :destroy
  has_many :genres, :through=>:prose_tags
  belongs_to :user
  has_paper_trail
end
