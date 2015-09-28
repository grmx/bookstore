# encoding: utf-8
class CoverUploader < MainUploader
  process resize_to_limit: [400, 400]

  version :thumb do
    process resize_to_limit: [200, 200]
  end
end
