class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    begin
      @image = Image.create!(image_params)
      respond_to do |f|
        f.json do
          render 'create'
        end
        f.html do
          redirect_to image_url(@image)
        end
      end
    rescue => e
      respond_to do |f|
        f.json do
          render json: { status: '500', message: "oops!" }
        end
        f.html do
          redirect_to :new
        end
      end
    end
  end

  def show
    begin
      @image = Image.find(params[:id])
    rescue
      respond_to do |f|
        f.json do
          render json: { status: '404', message: "image not found" }
        end
        f.html do
          redirect_to :new
        end
      end
    end
  end

  private

  def image_params
    params.require(:image).permit(:image, :image_cache)
  end
end
