class AddOriginalFileNameToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :original_file_name, :string
  end

  def self.down
    remove_column :videos, :original_file_name
  end
end
