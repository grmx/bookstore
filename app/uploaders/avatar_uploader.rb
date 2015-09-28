# encoding: utf-8
class AvatarUploader < MainUploader
  process resize_to_limit: [200, 200]

  version :thumb do
    process resize_to_fill: [30, 30]
  end
end
