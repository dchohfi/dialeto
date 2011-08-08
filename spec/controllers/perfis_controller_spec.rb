require "spec_helper"

describe PerfisController do
  
  before do
    @user = Factory(:user)
    sign_in @user
  end

  it "deve buscar os perfis por auto complete" do
    perfil = Factory(:perfil, :nome => "Perfil")
    outro_perfil = Factory(:perfil, :nome => "Outra")
      
    get :auto_complete, :q => "pER", :format => :json
  
    parsed_body = JSON.parse(response.body)
    parsed_body.count.should == 1
    parsed_body[0]['nome'] == perfil.nome
  end

  describe "ao salvar um perfil" do
    before do
      @user = Factory(:user)
      sign_in @user
    end

    def criar_perfil
      attributes = Factory.attributes_for(:perfil)
      post :create, :perfil => attributes
    end

    it "deve aumentar o contador de perfis" do 
      expect {
        criar_perfil
      }.to change(Perfil, :count).by(1)
    end

    it "deve redirecionar o usuario para a tela de listagem" do
      criar_perfil
      response.should redirect_to(perfis_url)
    end
  end
  
end