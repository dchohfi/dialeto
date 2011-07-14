class Contato
  include ActiveModel::Validations
  include ActiveModel::Conversion
  
  attr_accessor :nome, :email, :telefone, :assunto, :mensagem
  validates_presence_of :nome, :email, :assunto, :mensagem
  
  def persisted?
    false
  end
  
  def initialize(atributos = {})
    atributos.each do |nome, valor|
      send("#{nome}=", valor)
    end
  end
  
end