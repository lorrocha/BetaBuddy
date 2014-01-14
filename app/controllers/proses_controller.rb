class ProsesController < ApplicationController
  before_filter :authenticate_user!, except:[:show, :index, :search]
  before_filter :set_prose, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
  end

  def new
    @owner = current_user
    @prose = @owner.proses.build
  end

  def create
    @owner = current_user
    @prose = @owner.proses.build(prose_params)
    if @prose.save
      redirect_to user_prose_path(@prose.user,@prose), notice: 'Your ink has been committed to paper.'
    else
      render :new
    end
  end

  def show
    @prose = Prose.find(params[:id])

    #params['prose'].nil? ? version = 1 : version = params['prose']['version'].to_i
    # this is failing because the version.id is returning, not the version.index. FIIX
    #@prose ||= @prose.versions[version].reify
  end

  def edit
  end

  def destroy
    if @prose.destroy
      redirect_to user_proses_path(@prose.user), notice: "#{@prose.title} has been deleted."
    else
      redirect_to @prose, notice: "Woops, something went wrong!"
    end
  end

  def update
    original_prose = @prose
    if @prose.update(prose_params)
      if is_owner?
        redirect_to "/users/#{@prose.user.id}/proses/#{@prose.id}", notice: "#{@prose.title} has been updated."
        @prose.save
      else
        @prose.save
        redirect_to "/users/#{@prose.user.id}/proses/#{@prose.id}", notice: "Your edits have been submitted. #{@prose.user.username} will be seeing them soon!"
      end
    else
      render :new
    end
  end

  def search
    if params[:search]
      search_params = params[:search][:search]
    else
      search_params = nil
    end

    @proses = Prose.search(search_params)
  end

  private
  def is_owner?
    current_user == @prose.user
  end

  def set_prose
    @prose = Prose.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

  def prose_params
    params.require(:prose).permit(:user_id,:title, :description, :current_state)
  end

end
