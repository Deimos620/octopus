

class DefaultUploader  < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  storage Rails.configuration.carrierwave_storage

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :set_content_type


  def resize_and_crop(size)  
    manipulate! do |image|                 
      if image[:width] < image[:height]
        remove = ((image[:height] - image[:width])/2).round 
        image.shave("0x#{remove}") 
      elsif image[:width] > image[:height] 
        remove = ((image[:width] - image[:height])/2).round
        image.shave("#{remove}x0")
      end
      image.resize("#{size}x#{size}")
      image
    end
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

def filename 
  if original_filename 
    @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
    "#{@name}.#{file.extension}"
  end
end



end
