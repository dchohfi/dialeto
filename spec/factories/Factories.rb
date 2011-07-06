Factory.define :user do |user|
  user.username               "username"
  user.email                  "user@example.com"
  user.password               "password"
  user.password_confirmation  "password"
  user.perfil                  {Factory(:perfil)}
  user.role                   "admin"
end

Factory.define :perfil do |perfil|
  perfil.descricao            "Descricao"
end