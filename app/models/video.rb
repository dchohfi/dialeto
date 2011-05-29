class Video < ActiveRecord::Base
  before_save :upload_to_s3
  
  has_and_belongs_to_many :categorias, :join_table => "videos_categorias"
  validates_presence_of :nome, :message => "Digite um nome."
  validates_presence_of :local_path, :message => "Selecione um arquivo."
  validates_uniqueness_of :nome, :message => "Nome duplicado, informe outro."
  validates_uniqueness_of :local_path, :message => "Arquivo duplicado, informe outro."
  
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
  
end
