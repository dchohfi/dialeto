class UserBelongsToPerfil < ActiveRecord::Migration
  def self.up
    add_column :users, :perfil_id, :integer
  end

  def self.down
    remove_column :users, :perfil_id
  end
end