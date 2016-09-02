class PortraitUploader < DefaultUploader

 process :resize_to_fill => [1000 , 1500]



  # Create different versions of your uploaded files:

  version :lg do
      process :resize_to_fill => [400, 600]
  end

  version :md do
      process :resize_to_fill => [200, 300]
  end

  version :sm do
      process :resize_to_fill => [100, 150]
  end

  version :xs do
      process :resize_to_fill => [50, 75]
  end
  
  version :lg_thumbnail do
      process :resize_to_fill => [436, 252]
  end

  version :sm_thumbnail do
      process :resize_to_fill => [200, 116]
  end

  version :lg_square do
      process :resize_to_fill => [400, 400]
  end


   version :sm_square do
      process :resize_to_fill => [200, 200]
  end

end
