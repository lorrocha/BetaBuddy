class Prose < ActiveRecord::Base
  validates_numericality_of :current_state, :only_integer=>true
  validates_presence_of :description

  has_many :prose_tags,
   :inverse_of => :prose
  has_many :genres,
   :through=>:prose_tags
  belongs_to :user
  has_paper_trail :on => [:update, :create]

  def all_versions
    @work = versions.map {|v| {user_id:v.whodunnit, desc:v.reify.description} unless v.event == 'create'}
  end

  def self.search(params)
    if params
      where('description LIKE ? OR title LIKE ?', "%#{params}%", "%#{params}%")
    else
      all
    end
  end

end
