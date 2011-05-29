class PerfisHasManyCategorias < ActiveRecord::Migration
  def self.up
    create_table :categorias_perfis, :id => false do |t|
      t.references :perfil, :categoria
    end
  end

  def self.down
    drop_table :categorias_perfis
  end
end
