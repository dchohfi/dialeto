AWS::S3::Base.establish_connection!(
  :access_key_id => 'AKIAJTYLILIR2LG6E7JA',
  :secret_access_key => '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'
)

class S3Upload < AWS::S3::S3Object
  set_current_bucket_to 'dialeto_bucket'
end

class S3UploadJob < Struct.new(:upload_id)
  def perform
    Propaganda.find(upload_id).upload_to_s3
  end
end