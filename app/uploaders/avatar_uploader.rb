class AvatarUploader < DefaultUploader

      process :resize_to_fill => [300, 300]


  # Create different versions of your uploaded files:

  version :md do
      process :resize_to_fill => [150, 150]
  end

  version :sm do
      process :resize_to_fill => [75, 75]
  end

  version :xs do
      process :resize_to_fill => [25, 25]
  end
  

end
