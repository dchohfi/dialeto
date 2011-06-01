class AddMediaToPropaganda < ActiveRecord::Migration
  def self.up
    add_column :propagandas, :media_file_name,    :string
    add_column :propagandas, :media_content_type, :string
    add_column :propagandas, :media_file_size,    :integer
    add_column :propagandas, :media_updated_at,   :datetime
  end

  def self.down
    remove_column :propagandas, :media_file_name
    remove_column :propagandas, :media_content_type
    remove_column :propagandas, :media_file_size
    remove_column :propagandas, :media_updated_at
  end
end