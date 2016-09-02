class LandscapeUploader < DefaultUploader

 process :resize_to_fill => [1000 , 660]



  # Create different versions of your uploaded files:

  version :lg do
      process :resize_to_fill => [600, 400]
  end

  version :md do
      process :resize_to_fill => [300, 200]
  end

  version :sm do
      process :resize_to_fill => [150, 100]
  end

  version :xs do
      process :resize_to_fill => [75, 50]
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
