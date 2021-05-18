class CatalogueImagesUploader < CarrierWave::Uploader::Base
  storage :fog
  include CarrierWave::MiniMagick
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [200, 200]
  end

  def size_range
    1.byte..2.megabytes
  end
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
