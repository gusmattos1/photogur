class PicturesController < ApplicationController

before_action :ensure_logged_in, except: [:show, :index]
before_action :load_picture, only: [:show, :edit, :update, :destroy]
before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
    @pictures_newest = Picture.newest_first
    @pictures_newest_five = Picture.most_recent_five
    @pictures_before_month = Picture.created_before(Time.now - 1.month)
    @pictures_before_year = Picture.created_before(Time.now - 1.year)
  end

  def show
   end

   def new
      @picture = Picture.new
    end

    def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]
    @picture.user_id = current_user.id

    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
    else
      # otherwise render new.html.erb
      render :new
    end
  end

  def edit
  end

  def update

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]


    if @picture.save
      redirect_to "/pictures/#{@picture.id}"
    else
      render :edit
    end
  end

  def destroy
      @picture.destroy
      redirect_to "/pictures"
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    unless current_user.id == @picture.user_id
      flash[:alert] = "Please log in"
      redirect_to new_sessions_url
    end
  end

end
