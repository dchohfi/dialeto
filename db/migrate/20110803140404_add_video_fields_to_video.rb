class AddVideoFieldsToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :content_type, :string
    add_column :videos, :file_size, :string
    add_column :videos, :file_name, :string
  end

  def self.down
    remove_column :videos, :file_name
    remove_column :videos, :file_size
    remove_column :videos, :content_type
  end
end
