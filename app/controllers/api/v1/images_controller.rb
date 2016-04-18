class Api::V1::ImagesController < Api::V1::ApplicationController
  before_action :authenticate

  def create
    begin
      @image = Image.create!(image_params)
    rescue => e
      render json: { status: '500', message: "oops!" }
    end
  end

  def show
    begin
      @image = Image.find(params[:id])
    rescue
      render json: { status: '404', message: "image not found" }
    end
  end

  private

  def image_params
    params.require(:image).permit(:image, :image_cache)
  end
end
