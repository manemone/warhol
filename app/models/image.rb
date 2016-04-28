class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  before_destroy :remove_image!

  def aspect_ratio
    if width.present? && height.present?
      width.to_f / height.to_f
    else
      nil
    end
  end
end
