class AddNomeToPerfil < ActiveRecord::Migration
  def self.up
    add_column :perfis, :nome, :string
  end

  def self.down
    remove_column :perfis, :nome
  end
end