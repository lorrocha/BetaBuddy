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
    @genre_id = params['prose']['genres'].to_i
    @owner = current_user
    @prose = @owner.proses.build(prose_params)
    if @prose.save
      if @genre_id
        @prose.prose_tags.build(genre_id: @genre_id).save!
      end
      redirect_to user_prose_path(@prose.user,@prose), notice: 'Your ink has been committed to paper.'
    else
      render :new
    end
  end

  def show
    @prose = Prose.find(params[:id])

    if params['version'].nil?
      set_prose_description
    else
      story = params['version']['version']
      if !@prose.versions.where(id:story.to_i).empty?
          @prose.versions.find(story.to_i).event == 'create' ? set_prose_description : @story = @prose.versions.find(story.to_i).reify.description
      else
        set_prose_description
      end
    end
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
    if @prose.update(prose_params)
      @new_genre = params['prose']['genres'].to_i
      if is_owner?
        if @new_genre > 0
          @prose.switch_genres(@new_genre)
        end
        @prose.save
        redirect_to "/users/#{@prose.user.id}/proses/#{@prose.id}", notice: "#{@prose.title} has been updated."
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
      if params[:search][:genre].to_i > 0
        filter_id = params[:search][:genre].to_i
      else
        filter_id = nil
      end
    else
      search_params = nil
    end
    @proses = Prose.search(search_params, filter_id).paginate(:page => params[:page], :per_page => 20)
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

  def set_prose_description
    @story = @prose.description
  end

end
