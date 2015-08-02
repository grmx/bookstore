# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_limit: [200, 200]

  version :thumb do
    process resize_to_fill: [35, 35]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

end
