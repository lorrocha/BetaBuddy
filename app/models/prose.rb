class Prose < ActiveRecord::Base
  validates_presence_of :description

  has_many :prose_tags,
   :inverse_of => :prose,
   dependent: :destroy
  has_many :genres,
   :through=>:prose_tags
  belongs_to :user
  has_paper_trail :on => [:update, :create]

  def all_versions
    @work = versions.map {|v| {user_id:v.whodunnit, desc:v.reify.description} unless v.event == 'create'}
  end

  def self.search(item, filter)
    if item
      @search = joins('LEFT OUTER JOIN users ON proses.user_id = users.id').where('users.username LIKE ? OR title LIKE ?', "%#{item}%", "%#{item}%")
    else
      @search = all
    end
    self.filter(filter)
  end

  def switch_genres(id)
    if prose_tags.empty?
      prose_build(id)
    else
      tag = prose_tags.first
      prose_update(tag, id)
    end
  end

  def self.filter(id)
    if id
      #@search.joins('LEFT OUTER JOIN prose_tags ON proses.id = prose_tags.prose_id').joins('LEFT OUTER JOIN genres ON prose_tags.genre_id = genres.id').where('genre.id = ?', id)
      @search.joins('LEFT OUTER JOIN prose_tags ON proses.id = prose_tags.prose_id').joins('LEFT OUTER JOIN genres ON prose_tags.genre_id = genres.id').where('genres.id = ?', id)
    else
      @search
    end
  end

  def self.random_prose
    all.shuffle.pop
  end

  private

  def prose_build(id)
    prose_tags.build(genre_id:id).save!
  end

  def prose_update(tag, id)
    tag.update(genre_id:id)
    tag.save!
  end

  def filter(id)
    binding.pry
  end

end
