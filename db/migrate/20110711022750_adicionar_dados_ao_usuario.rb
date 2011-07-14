class AdicionarDadosAoUsuario < ActiveRecord::Migration
  def self.up
    add_column :users, :nome,       :string
    add_column :users, :nascimento, :datetime
    add_column :users, :cpf,        :string
    add_column :users, :telefone,   :string
    add_column :users, :endereco,   :string
    add_column :users, :sexo,       :string
    add_column :users, :status,     :boolean
  end

  def self.down
    remove_column :users, :nome
    remove_column :users, :nascimento
    remove_column :users, :cpf
    remove_column :users, :telefone
    remove_column :users, :endereco
    remove_column :users, :sexo
    remove_column :users, :status
  end
end
