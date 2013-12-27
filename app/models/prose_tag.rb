class ProseTag < ActiveRecord::Base
  validates_numericality_of :prose_id, :only_integer=>true
  validates_numericality_of :genre_id, :only_integer=>true

  belongs_to :genre
  belongs_to :prose
end
