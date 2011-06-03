class Perfil < ActiveRecord::Base
  validates_presence_of :descricao, :message => "ERRO PORRA"
  validates_uniqueness_of :descricao
  has_many :users
  has_and_belongs_to_many :videos, :join_table => "perfis_videos"
end