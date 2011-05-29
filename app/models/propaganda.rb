class Propaganda < ActiveRecord::Base
  
  has_and_belongs_to_many :categorias
  
  S3_ROOT_URL = 'http://s3.amazonaws.com/dialeto_bucket/'
  before_save :upload_to_s3
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
  
end
