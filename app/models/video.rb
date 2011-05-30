class Video < ActiveRecord::Base
  
  acts_as_taggable_on :tags
  has_many :images, :dependent => :destroy
  has_and_belongs_to_many :categorias, :join_table => "videos_categorias"
  validates_presence_of :nome, :message => "Digite um nome."
  validates_uniqueness_of :nome, :message => "Nome duplicado, informe outro."
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].nil? }
  
  attr_accessor :tag_list
  
end
