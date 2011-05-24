class S3Upload < AWS::S3::S3Object
  set_current_bucket_to 'dialeto_bucket'
end