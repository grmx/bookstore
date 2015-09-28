# encoding: utf-8
class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  process resize_to_limit: [400, 400]

  version :thumb do
    process resize_to_limit: [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
