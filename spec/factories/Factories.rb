Factory.define :user do |user|
  user.username               "username"
  user.email                  "username@example.com"
  user.password               "password"
  user.password_confirmation  "password"
  user.perfil                  {Factory(:perfil)}
  user.role                   "admin"
  user.nome                   "Diego Chohfi"
  user.endereco               "Rua Fagundes Varela 296"
  user.sexo                   "masculino"
  user.telefone               "12-88144904"
  user.cpf                    "381.819.658-33"
  user.nascimento             {Date.strptime("08/12/1987", '%d/%m/%Y')}
  user.locked                 false
end

Factory.define :useruser do |useruser|
  useruser.username               "user"
  useruser.email                  "user@example.com"
  useruser.password               "userpass"
  useruser.password_confirmation  "userpass"
  useruser.perfil                  {Factory(:perfil)}
  useruser.role                   "user"
  useruser.nome                   "User Dungle"
  useruser.endereco               "Rua Fagundes Varela 296"
  useruser.sexo                   "masculino"
  useruser.telefone               "12-88144904"
  useruser.cpf                    "381.819.658-33"
  useruser.nascimento             {Date.strptime("08/12/1987", '%d/%m/%Y')}
  useruser.locked                 false
end

Factory.define :perfil do |perfil|
  perfil.descricao            "Descricao"
  perfil.nome                 "Nome"
end

Factory.define :categoria do |categoria|
  categoria.nome "Categoria legal"
  categoria.descricao "Descricao bacana"
  categoria.images {[Factory(:image)]}
end

Factory.define :image do |image|
  path = %r|http://s3.amazonaws.com/dialeto_video_thumb/images/\d+/original/enterprise_logo.png|
  FakeWeb.register_uri(:any, path, :body => "OK")
  
  image.image { File.new(File.join(Rails.root, 'spec', 'support', 'enterprise_logo.png') ) }
end

Factory.define :propaganda do |propaganda|
  path = %r|http://s3.amazonaws.com/dialeto_propaganda/original/\d+/enterprise_logo.png|
  FakeWeb.register_uri(:any, path, :body => "OK")
  
  propaganda.nome "Propaganda legal"
  propaganda.image { File.new(File.join(Rails.root, 'spec', 'support', 'enterprise_logo.png') ) }
  propaganda.media { File.new(File.join(Rails.root, 'spec', 'support', 'enterprise_logo.png') ) }
  propaganda.categorias {[Factory(:categoria)]}
end

Factory.define :video do |video|
  path = %r|http://s3.amazonaws.com/dialeto_video/original/\d+/enterprise_logo.png|
  FakeWeb.register_uri(:any, path, :body => "OK")
  
  video.nome "Video legal"
  video.categorias {[Factory(:categoria)]}
  video.perfis {[Factory(:perfil)]}
  video.media { File.new(File.join(Rails.root, 'spec', 'support', 'enterprise_logo.png') ) }
  video.images {[Factory(:image)]}
end