# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  process resize_to_limit: [200, 200]

  version :thumb do
    process resize_to_fill: [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
