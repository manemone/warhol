class ImagesController < LoggedInController
  before_action :set_page, only: [:index]

  DEFAULT_PER_PAGE_NUM = 20

  def index
    @new_image = Image.new
    @images = Image.page(@page).per(DEFAULT_PER_PAGE_NUM)
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

  def set_page
    @page = params[:page] || 1
  end
end
