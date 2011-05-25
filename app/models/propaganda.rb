class Propaganda < ActiveRecord::Base
  include S3Module
  before_save :create_job
end
