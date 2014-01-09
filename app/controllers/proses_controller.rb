class ProsesController < ApplicationController
  before_filter :authenticate_user!, except:[:show, :index]
  before_filter :set_prose, except: [:new, :create, :index]

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
    if @prose.update(prose_params)
      if current_user == @prose.user
        # Do something to change the current_state of the prose and update the view hereeee
        redirect_to "/users/#{@prose.user.id}/proses/#{@prose.id}", notice: "#{@prose.title} has been updated."
      else
        redirect_to "/users/#{@prose.user.id}/proses/#{@prose.id}", notice: "Your edits have been submitted. #{@prose.user.username} will be seeing them soon!"
      end
    else
      render :new
    end
  end

  private

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
