require "spec_helper"

describe CategoriasController do
  
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "deve buscar as categorias por auto complete" do
      categoria = Factory(:categoria, :nome => "Categoria")
      outra_categoria = Factory(:categoria, :nome => "Outra")
            
      get :auto_complete, :q => "Cate", :format => :json
      
      parsed_body = JSON.parse(response.body)
      parsed_body.count.should == 1
      parsed_body[0]['nome'] == categoria.nome
    end
  
end