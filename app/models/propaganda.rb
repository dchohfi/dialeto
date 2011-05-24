class Propaganda < ActiveRecord::Base
  S3_ROOT_URL = 'http://s3.amazonaws.com/dialeto_bucket/'
  before_save :create_job
  attr_accessor :temp

  def s3_key
    local_path
  end
  
  def upload_to_s3
    S3Upload.store(s3_key, @temp.read, :access => :public_read)
  end
  
  def s3_url
    S3_ROOT_URL + s3_key
  end
  
  def create_job
    upload_to_s3
    #Delayed::Job.enqueue S3UploadJob.new(id)
  end
end
