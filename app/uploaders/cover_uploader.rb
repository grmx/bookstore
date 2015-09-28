# encoding: utf-8
class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  process resize_to_limit: [400, 400]

  version :thumb do
    process resize_to_limit: [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
