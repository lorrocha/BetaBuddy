class ProseTag < ActiveRecord::Base
  belongs_to :genre, :inverse_of => :prose_tags
  belongs_to :prose, :inverse_of => :prose_tags
end
