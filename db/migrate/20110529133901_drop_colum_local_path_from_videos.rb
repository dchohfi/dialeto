class DropColumLocalPathFromVideos < ActiveRecord::Migration
  def self.up
    remove_column :videos, :local_path
    remove_column :propagandas, :local_path
  end

  def self.down
    add_column :videos, :local_path, :string
    add_column :propagandas, :local_path, :string
  end
end