require "spec_helper"

describe PerfisController do
  
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "deve buscar os perfis por auto complete" do
      perfil = Factory(:perfil, :nome => "Perfil")
      outro_perfil = Factory(:perfil, :nome => "Outra")
          
      get :auto_complete, :q => "Per", :format => :json
      
      parsed_body = JSON.parse(response.body)
      parsed_body.count.should == 1
      parsed_body[0]['nome'] == perfil.nome
    end
  
end