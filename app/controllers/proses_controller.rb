class ProsesController < ApplicationController
  before_filter :authenticate_user!, except:[:show, :index]

  def new
      @owner = current_user
      @prose = @owner.proses.build
  end

  def create
    @owner = current_user
    @prose = @owner.proses.build(prose_params)
    if @prose.save
      redirect_to user_prose_path(@prose), notice: 'Your ink has been committed to paper.'
    else
      render :new
    end
  end

  def show
    @prose = Prose.find(params[:id])
  end

  def edit
    @prose = Prose.find(params[:id])
  end

  def update
    @prose = Prose.find(params[:id])
    if @prose.update(prose_params)
      redirect_to "/users/#{@prose.user.id}/proses/#{@prose.id}", notice: "#{@prose.title} has been updated."
    else
      render :new
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def prose_params
    params.require(:prose).permit(:user_id,:title, :description, :current_state)
  end

end
