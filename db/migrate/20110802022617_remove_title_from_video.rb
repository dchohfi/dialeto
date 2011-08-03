class RemoveTitleFromVideo < ActiveRecord::Migration
  def self.up
    remove_column :videos, :title
  end

  def self.down
    add_column :videos, :title, :string
  end
end
