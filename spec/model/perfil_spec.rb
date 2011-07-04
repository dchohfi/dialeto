#encoding: utf-8
require 'spec_helper'

describe Perfil do
  
  before do
    @perfil = Perfil.new
  end
  
  it 'deveria validar a preseça da descrição' do
    @perfil.should_not be_valid
    @perfil.should have_at_least(1).error_on(:descricao)
    @perfil.errors[:descricao].should include("Campo obrigatório")
  end
  
  it 'deveria salvar com sucesso' do
    @perfil.descricao = "Teste"
    quantidade = Perfil.count
    @perfil.save!
    @perfil.should be_valid
    @perfil.errors.should be_empty
    quantidade.should equal((Perfil.count - 1))
  end
  
  it 'não deveria salvar com a mesma descrição' do
    descricao = "Teste"
    @perfil.descricao = descricao
    @perfil.save!
    @perfil.should be_valid
    perfilInvalido = Perfil.new
    perfilInvalido.descricao = descricao
    perfilInvalido.should_not be_valid
    perfilInvalido.should have_at_least(1).error_on(:descricao)
    perfilInvalido.errors[:descricao].should_not include("Campo obrigatório")
    perfilInvalido.errors[:descricao].should include("Já cadastrado")
  end
  
end