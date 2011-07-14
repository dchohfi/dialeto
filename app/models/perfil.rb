class Perfil < ActiveRecord::Base
  validates_presence_of :descricao, :nome
  validates_uniqueness_of :nome
  has_many :users
  has_and_belongs_to_many :videos, :join_table => "perfis_videos"
end