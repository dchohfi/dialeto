class Propaganda < ActiveRecord::Base
  LOCAL_STORE_DIRECTORY = Rails.root.join('tmp', 'uploads')
  S3_ROOT_URL = 'http://s3.amazonaws.com/dialeto_bucket/'
  after_save :create_job
  
  def self.store_locally(uploaded_data)
    file_path = LOCAL_STORE_DIRECTORY.join(uploaded_data.original_filename)
    File.open(file_path, 'w'){|file| file.write(uploaded_data.read)}
    file_path.to_s
  end
  
  def s3_key
    File.basename(local_path)
  end
  
  def upload_to_s3
    S3Upload.store(s3_key, open(local_path), :access => :public_read)
  end
  
  def s3_url
    S3_ROOT_URL + s3_key
  end
  
  def create_job
    Delayed::Job.enqueue S3UploadJob.new(id)
  end
end
