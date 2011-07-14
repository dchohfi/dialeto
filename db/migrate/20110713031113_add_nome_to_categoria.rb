class AddNomeToCategoria < ActiveRecord::Migration
  def self.up
    add_column :categorias, :nome, :string
  end

  def self.down
    remove_column :categorias, :nome
  end
end