class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :nome
      t.string :descricao
      t.integer :perfil_id
      t.string :local_path

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
