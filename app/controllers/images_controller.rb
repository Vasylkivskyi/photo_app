class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    pp current_user.images
    @images = current_user.images
  end

  def show
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    pp 'hello', image_params
    @image = Image.new(image_params)
    @image.user = current_user
    begin
      if @image.save
        redirect_to @image, notice: 'Image was successfully created.'
      else
        render :new
      end
    rescue Exception => e
      flash[:error] = e.message
      render :new
    end
  end

  def update
    if @image.update(image_params)
      redirect_to @image, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @image.destroy
    redirect_to images_url, notice: 'Image was successfully destroyed.'
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:name, :photo)
    end
end
