module S3Module
  S3_ROOT_URL = 'http://s3.amazonaws.com/dialeto_bucket/'
  attr_accessor :file

  def s3_key
    local_path
  end
  
  def upload_to_s3
    S3Upload.store(s3_key, @file.read, :access => :public_read)
  end
  
  def s3_url
    S3_ROOT_URL + s3_key
  end
  
  def create_job
    upload_to_s3
    #Delayed::Job.enqueue S3UploadJob.new(id)
  end
end