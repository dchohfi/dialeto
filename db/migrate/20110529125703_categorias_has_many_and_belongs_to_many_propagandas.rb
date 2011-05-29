class CategoriasHasManyAndBelongsToManyPropagandas < ActiveRecord::Migration
  def self.up
    create_table :categorias_propagandas, :id => false do |t|
      t.references :categoria, :propaganda
    end
  end

  def self.down
    drop_table :categorias_propagandas
  end
end