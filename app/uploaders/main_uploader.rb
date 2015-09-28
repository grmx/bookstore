# encoding: utf-8
class MainUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    include Cloudinary::CarrierWave
  else
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
