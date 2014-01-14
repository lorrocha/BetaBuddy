class WelcomesController < ApplicationController
  def index
    @quote = Welcome.quotes.sample
  end
end
