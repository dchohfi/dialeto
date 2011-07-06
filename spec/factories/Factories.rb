Factory.define :user do |user|
  user.username               "username"
  user.email                  "user@example.com"
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.define :perfil do |perfil|
  perfil.descricao            "Descricao"
end