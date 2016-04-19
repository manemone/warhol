class ImagesController < LoggedInController
  def new
    @image = Image.new
  end

  def create
    begin
      @image = Image.create!(image_params)
      redirect_to image_url(@image)
    rescue => e
      redirect_to :new
    end
  end

  def show
    begin
      @image = Image.find(params[:id])
    rescue
      redirect_to :new
    end
  end

  private

  def image_params
    params.require(:image).permit(:image, :image_cache)
  end
end
