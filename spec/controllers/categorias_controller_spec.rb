require "spec_helper"

describe CategoriasController do
  
  before do
    @user = Factory(:user)
    sign_in @user
  end
    
  it "deve buscar as categorias por auto complete" do
    categoria = Factory(:categoria, :nome => "Categoria")
    outra_categoria = Factory(:categoria, :nome => "Outra")
      
    get :auto_complete, :q => "cATE", :format => :json

    parsed_body = JSON.parse(response.body)
    parsed_body.count.should == 1
    parsed_body[0]['nome'] == categoria.nome
  end
  
  describe "ao salvar uma categoria" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    def criar_categoria
      attributes = Factory.attributes_for(:categoria)
      post :create, :categoria => attributes
    end
    
    it "deve aumentar o contador de categorias" do 
      expect {
        criar_categoria
      }.to change(Categoria, :count).by(1)
    end
    
    it "deve redirecionar o usuario para a tela de visualizacao" do
      criar_categoria
      response.should redirect_to(Categoria.first)
    end
  end
  
end