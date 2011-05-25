class CreateVideosCategoriasJoinTable < ActiveRecord::Migration
  def self.up
    create_table :videos_categorias, :id => false do |t|
      t.integer :video_id
      t.integer :categoria_id
    end
  end

  def self.down
    drop_table :videos_categorias
  end
end
