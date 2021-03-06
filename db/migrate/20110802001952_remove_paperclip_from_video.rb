class RemovePaperclipFromVideo < ActiveRecord::Migration
  def self.up
    remove_column :videos, :media_file_name
    remove_column :videos, :media_content_type
    remove_column :videos, :media_file_size
    remove_column :videos, :media_updated_at
  end

  def self.down
    add_column :videos, :media_file_name,    :string
    add_column :videos, :media_content_type, :string
    add_column :videos, :media_file_size,    :integer
    add_column :videos, :media_updated_at,   :datetime
  end
end
