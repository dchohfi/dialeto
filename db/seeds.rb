perfil = Perfil.find_or_create_by_descricao("Administrador")
usuario = User.find_by_email('demo@demo.com')
if(!usuario)
  usuario = User.new(:email => 'demo@demo.com', :password => '123456', :password_confirmation => '123456', :remember_me => false, :perfil => perfil, :role => 'admin', :cpf => '381.819.658-33', :telefone => '12-88144904', :nome => 'Diego Chohfi', :nascimento => Date.strptime("08/12/1987", '%d/%m/%Y'), :sexo => 'masculino', :username => 'demo', :endereco => 'Rua Fagundes Varela, 296')
  usuario.save!
end