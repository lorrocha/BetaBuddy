class Welcome < ActiveRecord::Base

  def self.quotes
    [{"Oscar Wilde"=>"Be yourself; everyone else is already taken."},
      {"Me"=>"Awesome quote"}]
  end
end
