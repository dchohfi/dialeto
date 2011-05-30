class AddTagsToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :tag_list, :string
  end

  def self.down
    remove_column :videos, :tag_list
  end
end