class AddPandaGemToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :title, :string
    add_column :videos, :status, :string
    add_column :videos, :panda_video_id, :string
  end

  def self.down
    remove_column :videos, :panda_video_id
    remove_column :videos, :title
    remove_column :videos, :status
  end
end
