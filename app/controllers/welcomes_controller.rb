class WelcomesController < ApplicationController
  def index
    @quote = Quote.random
  end
end
