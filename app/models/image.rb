class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  before_destroy :remove_image!
end
