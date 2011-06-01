perfil = Perfil.find_or_create_by_descricao("Administrador")
usuario = User.find_by_email('demo@demo.com')
if(!usuario)
  usuario = User.new(email:'demo@demo.com', password:'123456', password_confirmation:'123456', remember_me:false, perfil:perfil, role:'admin')
  usuario.save!
end