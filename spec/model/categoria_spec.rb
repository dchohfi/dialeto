#encoding: utf-8
require 'spec_helper'

describe Categoria do
  
  subject {Factory(:categoria)}
  
  it { should validate_presence_of(:descricao) }
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:images) }
  it { should validate_uniqueness_of(:nome) }
  it { should have_many(:images) }
  
  it 'deve ter o mesmo tamanho de urls de imagem' do
    subject.images_url.size.should == subject.images.size
  end
  
  it "deve encontrar as categorias do usuario" do
    categoria = Factory(:categoria)
    video = Factory(:video, :categorias => [categoria])
    user = Factory(:user, :perfil => video.perfis.first)
    
    outra_categoria = Factory(:categoria)

    categorias_do_usuario = Categoria.categorias_do_usuario(user)
    categorias_do_usuario.should include(categoria)
    categorias_do_usuario.should_not include(outra_categoria)
  end
  
  it "deve conter todos os campos json" do
    Object.pathy!
    
    JSON.parse(subject.to_json).should have_json_path "categoria"
    JSON.parse(subject.to_json).should have_json_path "categoria.nome"
    JSON.parse(subject.to_json).should have_json_path "categoria.created_at"
    JSON.parse(subject.to_json).should have_json_path "categoria.updated_at"
    JSON.parse(subject.to_json).should have_json_path "categoria.id"
    JSON.parse(subject.to_json).should have_json_path "categoria.descricao"
    JSON.parse(subject.to_json).should have_json_path "categoria.images_url"
  end
end