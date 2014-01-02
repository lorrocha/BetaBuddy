class ProsesController < ApplicationController

  def new
    if user_signed_in?
      set_user
      @prose = @user.proses.build
    else
      redirect_to new_user_session_path, notice: 'Woops! Gotta sign in, first!'
    end
  end

  def create
    set_user
    @prose = @user.proses.build(prose_params)
    if @prose.save
      redirect_to user_prose_path(@prose), notice: 'Your ink has been committed to paper.'
    else
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end

  def prose_params
    params.require(:prose).permit(:user_id,:title, :description, :current_state)
  end

end
