class Prose < ActiveRecord::Base
  validates_numericality_of :user_id, :only_integer=>true
  validates_numericality_of :current_state, :only_integer=>true
  validates_presence_of :description
end
