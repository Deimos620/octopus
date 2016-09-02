class ThumbnailUploader < DefaultUploader

 # process :resize_to_fill => [300 , 200]


  # Create different versions of your uploaded files:

 
  version :lg do
      process :resize_to_fill => [436, 252]
  end

  version :sm do
      process :resize_to_fill => [200, 116]
  end

  version :xs do
      process :resize_to_fill => [100, 58]
  end

  version :square do
      process :resize_to_fill => [200, 200]
  end



  

end
