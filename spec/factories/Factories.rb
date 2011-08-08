Factory.define :user do |user|
  user.sequence(:username) {|n| "username#{n}"}
  user.sequence(:email) {|n| "username#{n}@example.com"}
  user.password "password"
  user.password_confirmation "password"
  user.perfil {Factory(:perfil)}
  user.role "admin"
  user.nome "Diego Chohfi"
  user.endereco "Rua Fagundes Varela 296"
  user.sexo "masculino"
  user.telefone "12-88144904"
  user.cpf "381.819.658-33"
  user.nascimento {Date.strptime("08/12/1987", '%d/%m/%Y')}
  user.locked false
end

Factory.define :perfil do |perfil|
  perfil.sequence(:descricao){|n| "Descricao#{n}"}
  perfil.sequence(:nome){|n| "Nome#{n}"}
end

Factory.define :categoria do |categoria|
  categoria.sequence(:nome){|n| "Categoria legal#{n}"}
  categoria.sequence(:descricao){|n| "Descricao bacana#{n}" }
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
  
  propaganda.sequence(:nome){|n| "Propaganda legal#{n}"}
  propaganda.image { File.new(File.join(Rails.root, 'spec', 'support', 'enterprise_logo.png') ) }
  propaganda.media { File.new(File.join(Rails.root, 'spec', 'support', 'enterprise_logo.png') ) }
  propaganda.categorias {[Factory(:categoria)]}
end

Factory.define :video do |video|
  video.sequence(:nome){|n| "Video legal#{n}"}
  video.categorias {[Factory(:categoria)]}
  video.perfis {[Factory(:perfil)]}
  video.panda_video_id '1234'
  video.status 'pending'
  video.sequence(:tag_list) {|n| "tag#{n}"}
  video.images {[Factory(:image)]}
end