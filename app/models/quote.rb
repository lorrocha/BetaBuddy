class Quote < ActiveRecord::Base

  def self.random
    all.shuffle.pop
  end
end
