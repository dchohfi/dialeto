class CreateVideosCategoriasJoinTable < ActiveRecord::Migration
  def self.up
    create_table :categorias_videos, :id => false do |t|
      t.references :categoria, :video
    end
  end

  def self.down
    drop_table :videos_categorias
  end
end
