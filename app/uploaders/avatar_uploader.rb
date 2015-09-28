# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  process resize_to_limit: [200, 200]

  version :thumb do
    process resize_to_fill: [30, 30]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
