class ImagesController < LoggedInController
  before_action :set_page, only: [:index]

  DEFAULT_PER_PAGE_NUM = 20

  def index
    @new_image = Image.new
    @images = Image.order(created_at: :desc)
      .page(@page).per(DEFAULT_PER_PAGE_NUM)
  end

  def create
    begin
      @image = Image.create!(image_params)
      redirect_to images_url, notice: "Your image uploaded successfully."
    rescue => e
      redirect_to images_url, alert: "Could not upload your image."
    end
  end

  def show
    begin
      @image = Image.find(params[:id])
    rescue
      redirect_to images_url
    end
  end

  private

  def image_params
    params.require(:image).permit(:image, :image_cache)
  end

  def set_page
    @page = params[:page] || 1
  end
end
