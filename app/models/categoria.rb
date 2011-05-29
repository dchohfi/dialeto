class Categoria < ActiveRecord::Base
  validates_presence_of :descricao
  validates_uniqueness_of :descricao
  
  has_and_belongs_to_many :perfis  
  has_and_belongs_to_many :propagandas
end