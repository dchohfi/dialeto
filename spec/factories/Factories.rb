Factory.define :user do |user|
  user.username               "username"
  user.email                  "user@example.com"
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

Factory.define :perfil do |perfil|
  perfil.descricao            "Descricao"
  perfil.nome                 "Nome"
end