class S3Uploader
  S3_ROOT_URL = 'http://s3.amazonaws.com/dialeto_bucket/'
  attr_accessor :file, :local_path

  def s3_key
    local_path
  end
  
  def upload_to_s3
    S3Upload.store(s3_key, @file.read, :access => :public_read)
  end
  
  def s3_url
    S3_ROOT_URL + s3_key
  end
end