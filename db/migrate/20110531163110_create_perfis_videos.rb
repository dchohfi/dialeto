class CreatePerfisVideos < ActiveRecord::Migration
  def self.up
    create_table :perfis_videos, :id => false do |t|
      t.references :perfil, :video
    end
  end

  def self.down
    drop_table :perfis_videos
  end
end